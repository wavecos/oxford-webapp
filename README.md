# README - Oxford Webapp

## Setup

Need to obtain Oxford APP_ID and APP_KEY from this url:

https://developer.oxforddictionaries.com/

With the APP_ID and APP_KEY need to use Rails secrets and register the keys:

```
EDITOR=nano rails credentials:edit
```

If you get this message:

"Couldn't decrypt config/credentials.yml.enc. Perhaps you passed the wrong key?"

You need to remove: config/credentials.yml.enc file and trye again:

Basically you need to add at the end of file:

```
app_id: XXXXXXXXXX
app_key: YYYYYYYYYY
```

