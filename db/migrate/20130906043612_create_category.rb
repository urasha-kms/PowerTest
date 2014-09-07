class CreateCategory < ActiveRecord::Migration
  def change
    create_table :category, :id => false do |t|
      t.integer :id_category
      t.text :name
      t.text :short
      t.integer :id_parent
      t.text :namepropis
    end
    reversible do |dir|
      dir.up do
        execute "ALTER TABLE ut_test_category ADD PRIMARY KEY (id_category);"
      end
    end
  end
end
