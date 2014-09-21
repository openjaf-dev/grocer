class Address < ActiveRecord::Base
  include AccountScoped
  
  belongs_to :organization
end
