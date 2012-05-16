module VagrantPlugininspection
  module UI
    class Columnized < Vagrant::UI::Colored

      class LayoutError < StandardError; end

      class Layout

        BOOL_MAP = {
          true => '*',
          false => '',
          nil => ''
        }

        # @param [Array] _optional_ Array with column names for a simple layout. Columns will be seperated by tab.
        def initialize(simple=nil)
          simple.each { |column|
            self.column(column)
            self.seperator("\t")
          } if simple

          @heads   = Hash.new
          @columns = Hash.new
          @stack   = Array.new
        end

        # Adds a column definition to the current position
        def column(key, opts=nil)
          defaults = { :name => key.to_s }
          opts     = defaults.merge(opts || {})

          @heads[key] = opts[:name]
          @columns[key] = opts
          @stack << key
        end

        # Adds a seperator to the current position
        def seperator(str)
          @stack << str.to_s
        end

        # Returns an Array of columns formatted lines. 
        # Also includes column headers and horizonal header line.
        # @return [Array] Returns an Array of formatted lines
        def rows(data, opts=nil)
          defaults = { :heads => true }
          opts     = defaults.merge(opts || {})

          data = clean(data)
          size = sizes(data)

          rendered = Array.new
          if opts.delete(:heads)
            rendered << columnize_row(@heads, size)
            rendered << horizontal_line(size)
          end
          rendered << data.map { |line| columnize_row(line, size) }

          # return a flat Array with lines
          rendered.flatten
        end

        protected

          def column_name(key)
            col = @heads[key]
            (col || key).to_s
          end

          # translate boolean values using BOOL_MAP
          # strips whitespace and newline
          def clean(data)
            data.map{|line|
              Hash[line.map{ |col| 
                col[1] = BOOL_MAP[col[1]] || col[1].to_s.strip.gsub(/^\s+|\s+$/, '').gsub(/\n|\r/,' ')
                col
              }]
            }
          end
          
          # determinate the size of each column
          def sizes(data)
            s = {}
            data.each { |line| 
              line.each_pair { |key, value|
                s[key] = [column_name(key).length, value.length, (s[key] || 0)].max
              }
            }
            s
          end

          def columnize_row(row, sizes)
            @stack.map { |piece| 
              if piece.is_a? String
                piece
              else
                sprintf "%-#{sizes[piece]}s", row[piece]
              end
            }.join
          end

          def horizontal_line(sizes)
            @stack.map { |piece|
              if piece.is_a? String
                piece
              else
                '-' * sizes[piece]
              end
            }.join
          end

      end # Layout

      def print_columns(data, opts=nil, &block)
        defaults = {}
        opts     = defaults.merge(opts ||= {})
        layout   = opts.delete(:layout)
        columns  = opts.delete(:columns)
        
        layout ||= if block_given?
          self.layout(&block)
        elsif columns && !columns.empty?
          Layout.new(columns)
        else
          raise LayoutError, "You need to pass a layout information, either as a block or array."
        end

        rendered = layout.rows(data, opts).map { |line| 
          format_message(:info, line, opts) 
        }.join("\n")

        # force the prefix off, we'd allready handled that
        opts[:prefix] = false

        say :info, rendered, opts
      end

      protected 

        # helper to create us a Layout instance and prime using a given block
        def layout(&block)
          layout = Layout.new
          layout.instance_eval(&block)
          # return the layout descriptor
          layout
        end
    
    end # Columnized
  end
end