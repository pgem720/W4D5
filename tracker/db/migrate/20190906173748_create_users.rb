class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username, :password_digest, :session_token, null: false
      
      t.timestamps
    end
    add_index :users, :session_token, unique: true
    add_index :users, :username, unique: true
  end
end
