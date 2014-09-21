class AddAccountReferencesToProductsTaxons < ActiveRecord::Migration
  def change
    add_reference :products_taxons, :account, index: true
  end
end
