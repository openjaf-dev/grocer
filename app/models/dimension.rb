class Dimension < ActiveRecord::Base
  belongs_to :account
  
  belongs_to :image
end
