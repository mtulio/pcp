# CONTRIBUTING

## Code

* Don't submit code without check manifests with puppet parser validate
* Don't submit code without check manifests with puppet lint
  * Don't submit yaml files without the proper validation
* Put vars always on top of the manifest file
* Hiera lookups should be used only in profile classes

## Commits

* Make commits of logical units.
* Check for unnecessary whitespace with "git diff --check" before committing.
* Commit using Unix line endings (check the settings around "crlf" in git-config(1)).
* The first line of the commit message should be a short description (50 characters is the soft limit, excluding ticket number(s)), and should skip the full stop.
