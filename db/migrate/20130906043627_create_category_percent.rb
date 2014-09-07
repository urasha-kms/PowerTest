class CreateCategoryPercent < ActiveRecord::Migration
  def up
    create_table :category_percent, :id => false do |t|
      t.integer :id_category_percent, null: false
      t.integer :id_category_main, null: false
      t.integer :id_category, null: false
      t.integer :percent, null: false
      t.integer :id_topic, null: false
    end
    execute "ALTER TABLE ut_test_category_percent ADD PRIMARY KEY (id_category_percent);
             ALTER TABLE ut_test_category_percent ADD CONSTRAINT fk_category FOREIGN KEY (id_category)
             REFERENCES ut_test_category (id_category) ON UPDATE NO ACTION ON DELETE CASCADE;
             ALTER TABLE ut_test_category_percent ADD CONSTRAINT fk_category_main FOREIGN KEY (id_category_main)
             REFERENCES ut_test_category (id_category) ON UPDATE NO ACTION ON DELETE CASCADE;
             ALTER TABLE ut_test_category_percent ADD CONSTRAINT uk_category_main UNIQUE (id_category_main, id_category, id_topic);"
  end
  def down
    execute "ALTER TABLE ut_test_category_percent DROP CONSTRAINT fk_category;
             ALTER TABLE ut_test_category_percent DROP CONSTRAINT fk_category_main;
             ALTER TABLE ut_test_category_percent DROP CONSTRAINT uk_category_main;"
    drop_table :category_percent
  end
end