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
$ vagrant plugins [-a|--all]
```

* `-a|--all` : Display *vagrant's* builtin plugins as well.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
