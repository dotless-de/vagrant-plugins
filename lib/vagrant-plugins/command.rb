require 'optparse'

module VagrantPlugininspection
  class Command < Vagrant::Command::Base

    def execute
      options = {}
      opts = OptionParser.new do |opts|
        opts.banner = "Usage: vagrant plugins"
        opts.separator ""

        opts.on("-a", "--all", "List builtin vagrant plugins as well.") do
          options[:all] = true
        end
      end

      argv = parse_options(opts)
      return if !argv

      ui = VagrantPlugininspection::UI::Columnized.new('plugins')

      if Vagrant.plugin("1").registered.empty?
        ui.info "No plugins registered"
      else

        builtins = VagrantPlugins.constants.map { |p| 
          VagrantPlugininspection::Inflector::constantize("VagrantPlugins::#{p}::Plugin") 
        } if !options[:all]
        
        plugins = Vagrant.plugin("1").registered.map { |plugin|
          if options[:all] || !builtins.include?(plugin)
            {
              :name => plugin.name, 
              :description => plugin.description
            }
          end
        }.compact

        ui.print_columns plugins, :column_order => [:name, :description]
      end
    end

  end
end