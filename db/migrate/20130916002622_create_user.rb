class CreateUser < ActiveRecord::Migration
  def up
#    create_table :user, :id => false do |t|
    create_table :user, primary_key: 'id_user' do |t|
#      t.integer :id_user
      t.text :name, null: false
      t.text :email, null: false
      t.text :remember_token, null: false
#      t.text :password, null: false
#      t.text :encrypted_password
#      t.text :salt
      t.integer :admin, null: false, :default => 0
      t.date :date_start
      t.date :date_stop
      t.integer :count_session, null: false, :default => 0
      t.text :password_digest, null: false 
    end
#    execute "ALTER TABLE ut_test_user ADD PRIMARY KEY (id_user);"
    add_index :user, :email, :unique => true
    add_index :user, :name, :unique => true
    add_index :user, :remember_token, :unique => true
  end
  def down
    drop_table :user
  end
end
