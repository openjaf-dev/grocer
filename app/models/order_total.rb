class OrderTotal < ActiveRecord::Base
  belongs_to :account
  
  belongs_to :order
end
