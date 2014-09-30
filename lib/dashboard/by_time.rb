module Dashboard
  module ByTime
    extend ActiveSupport::Concern
    
    def self.included(base)
       base.extend(ClassMethods)
    end

    module ClassMethods

      def data_by(collection, base_cal, fun, date_field, calculation, opts = {})
        acumulate = "beginning_of_#{opts[:filter]}"
        
        collection = collection.group_by do |o| 
          opts[:filter].present? ? o.send(date_field).send(acumulate) : o.send(date_field)
        end  
        
        p = eval( "lambda { |coll| coll.map" + send("fun_#{base_cal}") + ".#{calculation} }")
        
        collection = if fun =='time_line' 
          collection.map {|k,v| [k,p.call(v)]} 
        else 
          collection.sort.map {|c| [send(acumulate)[c[0]], [k,p.call(c[1])] ]}
        end  
        
        [{:data => collection.sort }]
      end

    end
  end 
end