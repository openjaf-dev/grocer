module Dashboard
  module ControllerHelpers
    module ByTime
      extend ActiveSupport::Concern

      def self.included(base)
         base.extend(ClassMethods)
      end

      module ClassMethods
        
        def compute
         # abstrack method that should be define in the class decorated
        end  
        
        def data_by(fun, opts = {})
          opts[:date_field] ||= :created_at
          opts[:range_date] ||= 'this_year'
          opts[:filter] ||= 'week'
          
          params = get_params(opts)
          collection = self.where(conditions(opts[:date_field], params))
          collection = collect_by(fun, collection, opts[:date_field], opts ).sort
          [{:name => "#{params[:from]}/#{params[:to]} ", :data => collection }]
        end
        
        def collect_by(fun, collection, date_field, opts = {})
          case fun
          when 'time_line'
            collection.group_by { |o| o.send(opts[:date_field]).send("beginning_of_#{opts[:filter]}" )}.map { |k, v| [k,compute(v)] }  
          else       
            elemnts = get_elements(fun)   
            collection.group_by {|o| o.select(date_field).send(elements)}.sort.map { |c| [self.send(fun)[c[0]], compute(c[1])] }
          end
        end
        
        def get_elements(fun)
          elements = case fun
          when 'hours' then %w(12am 1am 2am 3am 4am 5am 6am 7am 8am 9am 10am 11am 12m 1pm 2pm 3pm 4pm 5pm 6pm 7pm 8pm 9pm 10pm 11pm)
          when 'wday' then %w(Sunday Monday Tuesday Wednesday Thursday Friday Saturday)
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
        
        def conditions(date_field, opts)
          if opts.key? :to
            ["#{date_field} >= ? AND #{date_field} <= ?", opts[:from], opts[:to]]
          else
            ["#{date_field}  >= ?", opts[:from]]
          end
        end

      end
        
    end 
  end
end
