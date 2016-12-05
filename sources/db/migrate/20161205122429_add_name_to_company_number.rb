class AddNameToCompanyNumber < ActiveRecord::Migration[5.0]
  def change
    add_column :company_numbers, :name, :string
  end
end
