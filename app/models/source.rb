class Source < ActiveRecord::Base
  include AccountScoped
  
  belongs_to :payment
  validates_presence_of :name, :cc_type
end
