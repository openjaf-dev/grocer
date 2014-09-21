class AddAccountReferencesToSources < ActiveRecord::Migration
  def change
    add_reference :sources, :account, index: true
  end
end
