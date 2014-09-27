module Dashboard
  module ByTime
    extend ActiveSupport::Concern
    
    def self.included(base)
       base.extend(ClassMethods)
    end

    module ClassMethods
      def cal
       # abstrack method that should be define in the class decorated
      end

      def data_by(collection, fun, date_field, opts)
        puts "************* data_by opts[:filter] #{opts[:filter]}"
        collection = collect_by(collection, fun, date_field, opts ).sort
        [{:data => collection }]
      end

      def collect_by(collection, fun, date_field, opts = {})
        puts "************ fun collect_by #{fun}"



        if date_field
          collection = collection.group_by {|o| opts[:filter].present? ? o.send(date_field).send("beginning_of_#{opts[:filter]}") : o.send(date_field)}
        else
          collection = collection.group_by {|o| opts[:filter].present? ? o.send('placed_on').send("beginning_of_#{opts[:filter]}") : o.send('placed_on')}
        end

        case fun
          when 'time_line'
            collection.map {|k, v| [k,cal(v)] }
          else
            collection.sort.map {|c| [self.send("beginning_of_#{opts[:filter]}")[c[0]], cal(c[1])]}
        end

      end

    end
  end 
end