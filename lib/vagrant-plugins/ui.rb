module VagrantPlugininspection
  module UI
    class Columnized < Vagrant::UI::Colored

      def say(type, message, opts=nil)
        defaults = { :new_line => true, :prefix => true }
        opts     = defaults.merge(opts || {})
        super
      end

      def print_columns(data, opts=nil)
        defaults = { :prefix => false }
        opts     = defaults.merge(opts ||= {})

        columns = opts.delete(:column_order)

        data = clean(data, opts)
        size = sizes(data)

        table_head = columnize_row(columns.zip(columns), size, columns) + "\n" 
        table_head << (table_head.gsub(/[^\t]/, '-')) + "\n"
        table_body = data.map { |line| columnize_row(line, size, columns) }.join("\n")
        
        say :info, table_head << table_body, opts
      end

      protected 

        BOOL_MAP = {
          true => '*',
          false => '',
          nil => ''
        }

        def clean(data, opts=nil)
          data.map{|line|
            Hash[line.map{ |col| 
              col[1] = BOOL_MAP[col[1]] || col[1].to_s.strip.gsub(/^\s+|\s+$/, '').gsub(/\n|\r/,' ')
              col
            }]
          }
        end
        
        def sizes(data)
          s = {}
          data.each { |line| 
            line.each_pair { |key, value|
              s[key] = [key.length, value.length, (s[key] || 0)].max
            }
          }
          s
        end

        def columnize_row(row, size, columns=nil)
          data = Hash[row.map { |key, value|
            [key, "%-#{size[key]}s" % [value]]
          }]

          (columns ? columns.map { |col| data[col] } : data.values).join("\t")
        end
    end
  end
end