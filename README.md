vagrant-plugins
===============

A vagrant plugin to list active vagrant plugins.



## Installation

If you use the gem version of Vagrant, use:

```bash
$ gem install vagrant-dns
```

otherwise, use:

```bash
$ vagrant gem install vagrant-dns
```

And add this line to your `.vagrantrc` or `Vagrantfile`:

```ruby
Vagrant.require_plugin 'vagrant-plugins'
```

## Usage

```bash
$ vagrant plugins
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
