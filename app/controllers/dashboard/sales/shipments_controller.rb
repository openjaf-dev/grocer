module Dashboard
  module Sales
    class ShipmentsController < ApplicationController
      include Dashboard::ControllerHelpers::ByTime
      
      def klass_to_call
        Order  
      end
      
      def compute(orders)
         orders.sum { |o| o.totals.nil? ? 0 : o.totals.shipping }.round(2)
      end  
    end
  end
end