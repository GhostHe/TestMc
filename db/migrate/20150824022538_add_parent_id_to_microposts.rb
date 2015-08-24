class AddParentIdToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :parent_id, :integer
  end
end
