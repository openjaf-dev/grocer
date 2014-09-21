class Property < ActiveRecord::Base
  include AccountScoped
  
  belongs_to :product
end
