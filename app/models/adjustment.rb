class Adjustment < ActiveRecord::Base
  include AccountScoped
  
  belongs_to :order
  validates_presence_of :name, :value
end
