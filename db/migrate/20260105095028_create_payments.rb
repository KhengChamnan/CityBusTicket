class CreatePayments < ActiveRecord::Migration[8.1]
  def change
    create_table :payments do |t|
      t.references :booking, null: false, foreign_key: true
      t.decimal :amount, precision: 10, scale: 2
      t.string :payment_method
      t.integer :status , null: true , default: 0
      t.timestamps
    end
  end
end
