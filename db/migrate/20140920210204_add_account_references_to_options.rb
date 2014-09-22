class AddAccountReferencesToOptions < ActiveRecord::Migration
  def change
    add_reference :options, :account, index: true
  end
end
