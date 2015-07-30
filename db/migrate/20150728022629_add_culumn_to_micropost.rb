class AddCulumnToMicropost < ActiveRecord::Migration
  def change
    add_column :microposts, :is_good, :integer
  end
end
