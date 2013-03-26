class AddPhoneToUsers < ActiveRecord::Migration
  def change
    add_column :users, :business, :string
    add_column :users, :mobile, :string
  end
end
