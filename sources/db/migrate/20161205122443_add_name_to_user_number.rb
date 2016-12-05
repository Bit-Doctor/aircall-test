class AddNameToUserNumber < ActiveRecord::Migration[5.0]
  def change
    add_column :user_numbers, :name, :string
  end
end
