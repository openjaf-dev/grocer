class Organization < ActiveRecord::Base
  include AccountScoped
  
  has_one :address
  accepts_nested_attributes_for :address
  
  belongs_to :account
end
