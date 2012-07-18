require 'optparse'

module VagrantPlugininspection
  class Command < Vagrant::plugin("1", :command)

    def execute
      options = {}
      opts = OptionParser.new do |opts|
        opts.banner = "Usage: vagrant plugins"
        opts.separator ""

        opts.on("-a", "--all", "List builtin vagrant plugins as well.") do
          options[:all] = true
        end

        opts.on("-H", "--no-head", "Do not print descriptive headings") do 
          options[:no_heads] = true
        end

        opts.on("-v", "--verbose", "Be verbose and display plugin features") do
          options[:verbose] = true
        end
      end

      argv = parse_options(opts)
      return if !argv

      ui = VagrantPlugininspection::UI::Columnized.new('plugins')

      builtins = [VagrantPlugininspection::Plugin]
      builtins += VagrantPlugins.constants.map { |p| 
        VagrantPlugininspection::Inflector::constantize("VagrantPlugins::#{p}::Plugin") 
      }

      plugins = Vagrant.plugin("1").registered - builtins

      if !options[:all] && plugins.empty?
        ui.info "No plugins registered"
        # return a falsy value to the shell
        return 1
      end

      infos = (options[:all] ? Vagrant.plugin("1").registered : plugins).map { |plugin|
        info = {
          :name => plugin.name, 
          :description => plugin.description
        }

        info.merge!({
          :hosts        => !!plugin.data[:hosts],
          :guests       => !!plugin.data[:guests],
          :provisioners => !!plugin.data[:provisioners],
          :commands     => plugin.data[:command] && !plugin.command.to_hash.empty?,
          :action_hooks => !!plugin.data[:action_hooks],
          :configs      => plugin.data[:config] && !plugin.config.to_hash.empty?,
        }) if options[:verbose]

        # return the plugins info Hash
        info
      }.compact

      if options[:verbose] && !options[:no_heads]
        head = <<-EOS
+- hosts
|+- guests
||+- provisioners
|||+- commands
||||+- action_hooks
|||||+- configs
EOS
        ui.info head, :prefix => false
      end

      ui.print_columns(infos, :heads => !options[:no_heads]) do 
        if options[:verbose]
          column :hosts, :name => '|' 
          column :guests, :name => '|'
          column :provisioners, :name => '|'
          column :commands, :name => '|'
          column :action_hooks, :name => '|'
          column :configs, :name => '|'
          seperator "\t"
        end
        column :name
        seperator "\t"
        column :description
      end
      
    end # execute
  end # Command
end