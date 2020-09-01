# ScriptPack consumer

This is a fully functional example project accompanying the [ScriptPack](https://github.com/SoftwareAG/scriptpack) project.

To try the example clone this repo and run:

```
gradle clean build copyCurrentJvmToPayload copyLibsToPayload zipPayload generateScriptPack
```

Then go to build/distributions and run:

```
scriptpack -d C:\myapp --internal-skip-privilege-check
```

***

This code is provided as-is and without warranty or support. It does not constitute part of the Software AG product suite. Users are free to use, fork and modify it, subject to the license agreement. While Software AG welcomes contributions, we cannot guarantee to include every contribution in the master project.