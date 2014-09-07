class CreateTicket < ActiveRecord::Migration
  def up
    create_table :ticket, :id => false do |t|
      t.integer :id_numticket
      t.integer :id_quest
      t.integer :iddb_quest
      t.integer :num, null: false
      t.index [:id_numticket, :num]
    end
    execute "ALTER TABLE ut_test_ticket ADD PRIMARY KEY (id_numticket, id_quest, iddb_quest);
             ALTER TABLE ut_test_ticket ADD CONSTRAINT fk_ticket_nticket FOREIGN KEY (id_numticket)
              REFERENCES ut_test_numticket (id_numticket) ON UPDATE NO ACTION ON DELETE CASCADE;
             ALTER TABLE ut_test_ticket ADD CONSTRAINT fk_ticket_quest FOREIGN KEY (id_quest, iddb_quest)
              REFERENCES ut_test_quest (id_quest, id_db_quest) ON UPDATE NO ACTION ON DELETE CASCADE;
             ALTER TABLE ut_test_ticket ADD CONSTRAINT uk_ticket_numticket UNIQUE (id_numticket, id_quest, iddb_quest);"
  end
  def down
    execute "ALTER TABLE ut_test_ticket DROP CONSTRAINT fk_ticket_nticket;
             ALTER TABLE ut_test_ticket DROP CONSTRAINT fk_ticket_quest;
             ALTER TABLE ut_test_ticket DROP CONSTRAINT uk_ticket_numticket;"
    drop_table :ticket
  end
end