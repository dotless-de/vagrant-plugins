# v0.2.2

* include this plugin to the list of *buildin plugins*, which will cause it the be hidden by default.
* get the "no plugins" detection working. 

# v0.2.1

* fixes false positive feature detection for comfigs and commands

# v0.2.0

* Adds a verbose flag. Informs about plugin features such as "provides commands" or "action hook" etc.
* Adds a `--no-heads` flag. Swicth off the column descriptions.
* Revamped the internal UI component to use a nifty DSL to describe the column layout.

# v0.1.0

* simple list of all loaded plugin names
* optional override the default filter to non-builtin plugins by `--all` flag