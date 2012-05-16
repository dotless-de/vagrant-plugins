vagrant-plugins
===============

A vagrant plugin to list active vagrant plugins.

Since *vagrant 1.1* (which is not yet released) you need to specify which plugins you want to load. You may either use the global `.vagrant.rc` file or the projects `Vagrantfile`.
This can get a bit confusing when having a lot of different configurations or projects. 

This plugin aims to help you keeping track of which plugins are loaded in your project.

## Installation

If you use the gem version of Vagrant, use:

```bash
$ gem install vagrant-plugins
```

otherwise, use:

```bash
$ vagrant gem install vagrant-plugins
```

And add this line to your `.vagrantrc` or `Vagrantfile`:

```ruby
Vagrant.require_plugin 'vagrant-plugins'
```

## Usage

```bash
$ vagrant plugins [-a|--all] [-H|--no-head] [-v|--verbose]
```

* `-a|--all` : Display *vagrant's* builtin plugins as well.
* `-H|--no-head` : Do _not_ print descriptive column headings
* `-v|--verbose` : Be verbose and display plugin features

The *verbose* flag will print a check map like this:

```bash
$ vagrant plugins -v
+- hosts
|+- guests
||+- provisioners
|||+- commands
||||+- action_hooks
|||||+- configs
||||||	name              	description                                                                                                  
------	------------------	-------------------------------------------------------------------------------------------------------------
   ***	vbguest management	Provides automatic and/or manual management of the VirtualBox Guest Additions inside the Vagrant environment.                
   *  	plugins           	List all vagrant plugins loaded in the current vagrant environment                                          
```

Note, that the feature columns are not delimited by tab, an asterisk (`*`) will indicate that a feature is present.   
For example above: *vbguest management* registers *commands*, *action hooks* and *configs*, while *plugins* only registers *commands*.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
