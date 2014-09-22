class Shipment < ActiveRecord::Base
  include AccountScoped
  
  belongs_to :variant
  belongs_to :product
  belongs_to :order
end
