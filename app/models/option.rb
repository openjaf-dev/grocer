class Option < ActiveRecord::Base
  include AccountScoped
  
  belongs_to :variant
end
