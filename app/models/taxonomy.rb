class Taxonomy < ActiveRecord::Base
  include AccountScoped
  
  validates :name, presence: true

  has_many :taxons, inverse_of: :taxonomy
  has_one :root, -> { where parent_id: nil }, class_name: "Taxon", dependent: :destroy


  default_scope -> { order("#{self.table_name}.position") }
end
