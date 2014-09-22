module Dashboard
  module Purchases
    class TransactionsController < ApplicationController
      include Dashboard::ControllerHelpers::ByTime
      
      def klass_to_call
        Order  
      end
      
      def compute(value)
        value.count
      end  
    end
  end
end