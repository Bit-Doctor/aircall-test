class CreateCalls < ActiveRecord::Migration[5.0]
  def change
    create_table :calls do |t|
      t.string :uuid
      t.string :caller_number
      t.string :caller_name
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :user_number, index: true, foreign_key: true
      t.belongs_to :company_number, index: true, foreign_key: true
      t.string :record_url

      t.timestamps
    end
    add_index :calls, :uuid, unique: true
  end
end
