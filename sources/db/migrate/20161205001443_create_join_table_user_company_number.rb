class CreateJoinTableUserCompanyNumber < ActiveRecord::Migration[5.0]
  def change
    create_join_table :users, :company_numbers do |t|
      t.index [:user_id, :company_number_id]
      t.index [:company_number_id, :user_id]
    end
  end
end
