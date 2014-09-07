class CreateTopic < ActiveRecord::Migration
  def change
    create_table :topic, :id => false do |t|
      t.integer :id_topic
      t.text :name
      t.text :short
      t.integer :countmonth, null: false
    end
    reversible do |dir|
      dir.up do
        execute "ALTER TABLE ut_test_topic ADD PRIMARY KEY (id_topic);"
      end
    end
  end
end