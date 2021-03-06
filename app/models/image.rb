class Image < ActiveRecord::Base
  include AccountScoped
    
  belongs_to :variant
  belongs_to :product

  has_many :dimensions

  accepts_nested_attributes_for :dimensions

  validates_presence_of :url
end
