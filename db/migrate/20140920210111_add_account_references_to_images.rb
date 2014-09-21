class AddAccountReferencesToImages < ActiveRecord::Migration
  def change
    add_reference :images, :account, index: true
  end
end
