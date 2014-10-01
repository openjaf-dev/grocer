module Dashboard
  module ByTime
    extend ActiveSupport::Concern
    
    def self.included(base)
       base.extend(ClassMethods)
    end

    module ClassMethods

      def data_by(coll, base_cal, fun, date_field, calculation, acumulate = nil)
        acumulate = "beginning_of_#{acumulate}" if acumulate.present? && fun =='2-d'
        coll = coll.group_by { |o| acumulate.present? ? o.send(date_field).send(acumulate) : o.send(date_field) }
        fun_base = attribute_method? base_cal ? "(&:#{'total'})" : send("#{base_cal}")
        p = eval( "lambda { |coll| coll.map#{fun_base}.#{calculation} }")
        
        coll = if fun =='2-d' 
          coll.map { |k,v| [k,p.call(v)] } 
        else 
          coll.sort.map {|c| [ send(acumulate)[c[0]], p.call(c[1]) ] }
        end  
        
        [{:data => coll}]
      end   
      
      def wday
       Date::DAYNAMES
      end

      def hour
        %w(12am 1am 2am 3am 4am 5am 6am 7am 8am 9am 10am 11am 12m 1pm 2pm 3pm 4pm 5pm 6pm 7pm 8pm 9pm 10pm 11pm)      
      end

    end
  end 
end