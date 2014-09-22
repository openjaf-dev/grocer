class AddAccountReferencesToTaxonomies < ActiveRecord::Migration
  def change
    add_reference :taxonomies, :account, index: true
  end
end
