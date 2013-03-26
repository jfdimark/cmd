class AddMoreDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :recommendations, :string
    add_column :users, :skills, :string
    add_column :users, :num_recommendations, :string
    add_column :users, :connections, :string
    add_column :users, :groups, :string
  end
end
