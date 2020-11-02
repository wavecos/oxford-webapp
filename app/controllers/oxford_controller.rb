class OxfordController < ApplicationController
  def index
  end

  def search
    search_term(params[:term])
  end

  private
  def search_term(term)
    url = "https://od-api.oxforddictionaries.com/api/v2/entries/en-us/#{term.downcase}"

    begin
      response = Excon.get(
        url,
        headers: {
          'app_id' => Rails.application.credentials.app_id, # See README.md file for instructions
          'app_key' => Rails.application.credentials.app_key
        }
      )
    rescue StandardError => e
      flash[:alert] = e.message
      return render action: :index
    end

    if response.status != 200
      begin
        errorMsg = JSON.parse(response.body)['error'] # Check if the error is JSON obj
      rescue JSON::ParserError => e  
        errorMsg = response.body # Error msg is plain text
      end 

      flash[:alert] = errorMsg
      return render action: :index
    else
      resp = JSON.parse(response.body)
      @word = resp['word']
      @definition = resp['results'][0]['lexicalEntries'][0]['entries'][0]['senses'][0]['definitions'][0]   
      @provider = resp['metadata']['provider']
      @audio_url = resp['results'][0]['lexicalEntries'][0]['entries'][0]['pronunciations'][1]['audioFile']
    end

  end
end
