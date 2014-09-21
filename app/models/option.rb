class Option < ActiveRecord::Base
  belongs_to :account
  
  
  belongs_to :variant
end
