class LineItem < ActiveRecord::Base
  include AccountScoped
  
  belongs_to :order
  belongs_to :product
  belongs_to :variant

  validates_presence_of  :name, :quantity, :price
end
