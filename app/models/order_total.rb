class OrderTotal < ActiveRecord::Base
  include AccountScoped
  
  belongs_to :order
end
