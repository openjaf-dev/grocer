class Taxon < ActiveRecord::Base
  include AccountScoped
  
  acts_as_nested_set dependent: :destroy
  belongs_to :taxonomy, inverse_of: :taxons
  
  has_many :classifications, -> { order(:position) }, dependent: :delete_all, inverse_of: :taxon
  has_many :products, through: :classifications
  
  accepts_nested_attributes_for :products
end
