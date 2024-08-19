class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :surname
      t.references :created_by, null: false, foreign_key: { to_table: :users }
      t.references :last_updated_by, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
