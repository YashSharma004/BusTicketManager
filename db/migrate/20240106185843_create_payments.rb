class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.references :paid_by, foreign_key: { to_table: :users }, null: false
      t.references :paid_to, foreign_key: { to_table: :users }, null: false
      t.decimal :amount
      t.date :date

      t.timestamps
    end
  end
end
