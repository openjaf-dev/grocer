module Dashboard
  module ByTime
    extend ActiveSupport::Concern
    
    def self.included(base)
       base.extend(ClassMethods)
    end

    module ClassMethods

      def data_by(collection, base_cal, fun, date_field, calculation, opts = {})
        puts "************ fun collect_by #{fun}"
        collection = collection.group_by {|o| opts[:filter].present? ? o.send(date_field).send("beginning_of_#{opts[:filter]}") : o.send('placed_on')}
       
        p = eval( "lambda { |coll| coll.#{calculation}#{self.def_meth(base_cal)} }")
        
        collection = if fun =='time_line'
          collection.map { |k, v| [ k, p.call(v) ] } 
        else
          collection.sort.map {|c| [send("beginning_of_#{opts[:filter]}")[c[0]], [ k, p.call(c[1]) ] ]}
        end
        
        [{:data => collection.sort }]
      end

    end
  end 
end