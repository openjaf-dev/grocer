class AddAccountReferencesToTaxons < ActiveRecord::Migration
  def change
    add_reference :taxons, :account, index: true
  end
end
