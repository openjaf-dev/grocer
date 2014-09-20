class AddReferenceToAccounts < ActiveRecord::Migration
  def change
    add_reference :accounts, :organization, index: true
  end
end
