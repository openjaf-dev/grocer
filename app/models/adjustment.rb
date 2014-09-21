class Adjustment < ActiveRecord::Base
  belongs_to :account
  
  belongs_to :order
  validates_presence_of :name, :value
end
