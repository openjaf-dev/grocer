module Dashboard
  class OverviewController < ApplicationController
    def index
      @revenues = Order.where(:status => 'complete').count
      @orders = Order.count
      @overview_chart = {:Orders => @orders, :Revenues => @revenues }
    end
  end
end
