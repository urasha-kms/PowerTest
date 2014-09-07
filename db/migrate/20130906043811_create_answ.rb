class CreateAnsw < ActiveRecord::Migration
  def up
    create_table :answ, :id => false do |t|
      t.integer :id_answ
      t.integer :id_db_answ
      t.integer :id_quest, null: false
      t.integer :iddb_quest, null: false
      t.text    :text
      t.integer :good, null: false
      t.index [:id_quest, :iddb_quest]
    end
    execute "ALTER TABLE ut_test_answ ADD PRIMARY KEY (id_answ, id_db_answ);
             ALTER TABLE ut_test_answ ADD CONSTRAINT fk_answ_quest FOREIGN KEY (id_quest, iddb_quest)
              REFERENCES ut_test_quest (id_quest, id_db_quest) ON UPDATE NO ACTION ON DELETE CASCADE;"
  end
  def down
    execute "ALTER TABLE ut_test_answ DROP CONSTRAINT fk_answ_quest;"
    drop_table :answ
  end
end