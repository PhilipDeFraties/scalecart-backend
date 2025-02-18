class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :email, null: false, index: { unique: true }
      t.string :password_digest, null: false
      t.string :role, default: "customer", null: false

      t.timestamps
    end
    add_index :users, :email, unique: true, if_not_exists: true
  end
end
