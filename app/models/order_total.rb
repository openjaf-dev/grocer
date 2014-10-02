class OrderTotal < ActiveRecord::Base
  include AccountScoped
  include Dashboard::ByTime
  
  belongs_to :order
end
