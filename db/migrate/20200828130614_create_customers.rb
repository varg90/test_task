class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :email, default: '', null: false
      t.datetime :birthdate, null: false

      t.timestamps
    end
  end
end
