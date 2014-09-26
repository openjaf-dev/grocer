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
      
      def data_by(collection, fun = 'time_line', date_field = 'created_at', opts = {})
        opts[:filter] ||= 'week'
        if opts[:range_date].present? 
          params = get_params(opts)
          collection = collection.where(["#{date_field} >= ? AND #{date_field} <= ?", params[:from], params[:to]] )
        end  
        collection = collect_by(collection, fun, date_field, opts ).sort
        [{:data => collection }]
      end
      
      def collect_by(collection, fun, date_field, opts = {})
        collection = collection.group_by do |o| 
          if opts[:filter].present? 
            fil = get_elements(opts[:filter])
            o.send(date_field).send(fil)
          else
            o.send(date_field)
          end  
        end
        fun == 'time_line' ? collection.map { |k, v| [k,cal(v)] } : collection.sort.map { |c| [self.send(fun)[c[0]], cal(c[1])]} 
      end
      
      def get_elements(filter)
        elements = case filter
        when 'hours' then %w(12am 1am 2am 3am 4am 5am 6am 7am 8am 9am 10am 11am 12m 1pm 2pm 3pm 4pm 5pm 6pm 7pm 8pm 9pm 10pm 11pm)
        when 'wday' then %w(Sunday Monday Tuesday Wednesday Thursday Friday Saturday)
        else
          "beginning_of_#{filter}"
        end  
      end
      
      def get_params(opts)
       options = case opts[:range_date]
         when 'today'      then { from: Time.new().to_date.to_s(:db), to: Time.new().to_date.to_s(:db) }
         when 'yesterday'  then { from: (Time.new().to_date - 1.day).to_s(:db), to: Time.new().to_date.to_s(:db) }
         when '7_days'     then { from: (Time.new().to_date - 1.week).to_s(:db), to: Time.new().to_date.to_s(:db) }
         when '14_days'    then { from: (Time.new().to_date - 2.week).to_s(:db), to: Time.new().to_date.to_s(:db) }
         when 'this_month' then { from: Date.new(Time.now.year, Time.now.month, 1).to_s(:db), to: Date.new(Time.now.year, Time.now.month, -1).to_s(:db) }
         when 'last_month' then { from: (Date.new(Time.now.year, Time.now.month, 1) - 1.month).to_s(:db), to: (Date.new(Time.now.year, Time.now.month, -1) - 1.month).to_s(:db) }
         when 'this_year'  then { from: Date.new(Time.now.year, 1, 1).to_s(:db), to: Time.new().to_date.to_s(:db) }
         when 'last_year'  then { from: Date.new(Time.now.year - 1, 1, 1).to_s(:db), to: Date.new(Time.now.year - 1, 12, -1).to_s(:db) }
       end           
      end

    end
      
  end 
end
