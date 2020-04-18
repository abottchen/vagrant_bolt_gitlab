This is a rough draft of a bolt plan that installs and sets up a gitlab server in a docker container.

Yes, I know it is a terrible idea to ship certificates along with the package.

Usage:

```
# bolt puppetfile install -m modules --puppetfile ./Puppetfile
# bolt plan run vagrant_bolt_gitlab::install -m modules:.. -t TARGETS
```
