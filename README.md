This is a rough draft of a bolt plan that installs and sets up a gitlab server in a docker container.

Usage:

```
# bolt puppetfile install -m modules --puppetfile ./Puppetfile
# bolt plan run vagrant_bolt_gitlab::install -m modules:.. -t TARGETS
```

Note that the gitlab container takes about 5 minutes or so to start up, so don't panic if the plan takes awhile to run...
