module Dashboard
  module ByTime
    extend ActiveSupport::Concern
    
    def self.included(base)
       base.extend(ClassMethods)
    end

    module ClassMethods

      def data_by(collection, base_cal, fun, date_field, calculation, acumulate = nil )

        if acumulate == 'week'
          collection = calculate_week_days(collection,date_field,calculation)
        elsif acumulate == 'hour'
          collection = calculate_hours_of_day(collection,date_field,calculation)
        end

        #acumulate = "beginning_of_#{acumulate}" if acumulate.present? && fun =='2-d'
        
        #collection = collection.group_by do |o|
        #  acumulate.present? ? o.send(date_field).send(acumulate) : o.send(date_field)
        #end
        
        #p = eval( "lambda { |coll| coll.map" + send("fun_#{base_cal}") + ".#{calculation} }")
        
        #collection = if fun =='2-d'
        #  collection.map {|k,v| [k,p.call(v)]}
        #else
        #  collection.sort.map {|c| [ send(acumulate)[c[0]], p.call(c[1]) ] }
        #end
        
        [{:data => collection}]
      end   
      
      def wday
       Date::DAYNAMES
      end

      def hour
        %w(12am 1am 2am 3am 4am 5am 6am 7am 8am 9am 10am 11am 12m 1pm 2pm 3pm 4pm 5pm 6pm 7pm 8pm 9pm 10pm 11pm)      
      end

      def calculate_week_days(collection,date_field,calculation)
        col = collection.group_by{|c|c.send(date_field).wday}.sort{|x,y| x[0] <=> y[0] }
        result = []
        col.each do |c|
          if calculation == 'sum'
            result << [ wday[c[0]],c[1].sum{|x| x.totals.total}]
          else
            result << [ wday[c[0]],c[1].count]
          end
        end
        result
      end

      def calculate_hours_of_day(collection,date_field,calculation)
        col = collection.group_by{|c|c.send(date_field).hour}.sort{|x,y| x[0] <=> y[0] }
        result = []
        col.each do |c|
          if calculation == 'sum'
            result << [ hour[c[0]],c[1].sum{|x| x.totals.total}]
          else
            result << [ hour[c[0]],c[1].count]
          end
        end
        result
      end

    end
  end 
end