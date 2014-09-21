class Dimension < ActiveRecord::Base
  include AccountScoped
  
  belongs_to :image
end
