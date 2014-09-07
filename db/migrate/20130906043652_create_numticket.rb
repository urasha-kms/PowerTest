class CreateNumticket < ActiveRecord::Migration
  def up
    create_table :numticket, :id => false do |t|
      t.integer :id_numticket
      t.integer :id_category, null: false
      t.integer :nticket, null: false
      t.integer :id_topic, null: false
      t.index [:id_topic, :id_category]
      t.index [:id_topic, :id_category, :nticket]
     
    end
    execute "ALTER TABLE ut_test_numticket ADD PRIMARY KEY (id_numticket);
             ALTER TABLE ut_test_numticket ADD CONSTRAINT fk_numticket_category FOREIGN KEY (id_category)
              REFERENCES ut_test_category (id_category) ON UPDATE NO ACTION ON DELETE CASCADE;
             ALTER TABLE ut_test_numticket ADD CONSTRAINT fk_numticket_topic FOREIGN KEY (id_topic)
              REFERENCES ut_test_topic (id_topic) ON UPDATE NO ACTION ON DELETE CASCADE;
             ALTER TABLE ut_test_numticket ADD CONSTRAINT uk_numticket_nticket UNIQUE (id_topic, id_category, nticket);"
  end
  def down
    execute "ALTER TABLE ut_test_numticket DROP CONSTRAINT fk_numticket_category;
             ALTER TABLE ut_test_numticket DROP CONSTRAINT fk_numticket_topic;
             ALTER TABLE ut_test_numticket DROP CONSTRAINT uk_numticket_nticket;"
    drop_table :numticket
  end
end
