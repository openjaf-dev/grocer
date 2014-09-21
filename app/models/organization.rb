class Organization < ActiveRecord::Base
  belongs_to :account
  
  has_one :address
  accepts_nested_attributes_for :address
  
  belongs_to :account
end
