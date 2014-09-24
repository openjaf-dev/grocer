module Dashboard
  module Sales
    class RevenuesController < ApplicationController

      include Dashboard::ControllerHelpers::ByTime
      include Dashboard::ControllerHelpers::ByAmount

      def klass_to_call
        Order  
      end

      def compute(orders)
         orders.sum { |o| o.totals.nil? ? 0 : o.totals.total }.round(2)
         #.sum{|o| o.totals.total
      end

      def compute_amount(orders)
        orders.count
      end

      def by_sources
        @amount_data = Source.all
        @amount_data_table = @amount_data.clone
        amount_set_data_by(:cc_type)
        @amount_data_table = @amount_data_table
      end

      def by_heat
          @dates_values = []
          @dates_values << {:date => Time.now.to_i,:value => 25}
          @dates_values << {:date => (Time.now + 1.hours).to_i,:value => 25}
          @dates_values << {:date => (Time.now + 2.hours).to_i,:value => 25}
          @dates_values << {:date => (Time.now + 3.hours).to_i,:value => 100}
          @dates_values << {:date => (Time.now + 4.hours).to_i,:value => 25}
          @dates_values << {:date => (Time.now + 5.hours).to_i,:value => 25}
          @dates_values << {:date => (Time.now + 6.hours).to_i,:value => 25}
          @dates_values << {:date => (Time.now + 7.hours).to_i,:value => 25}

      end

    end
  end
end