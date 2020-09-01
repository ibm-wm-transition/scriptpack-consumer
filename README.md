# ScriptPack consumer - example project
Clone this repo and run:
```
gradle clean build copyCurrentJvmToPayload copyLibsToPayload zipPayload generateScriptPack
```
Then go to build/distributions and run:
```
scriptpack -d C:\myapp --internal-skip-privilege-check
```

