class CreateQuest < ActiveRecord::Migration
  def up
    create_table :quest, :id => false do |t|
      t.integer :id_quest
      t.integer :id_db_quest
      t.integer :id_topic, null: false
      t.integer :id_category, null: false
      t.text    :text
      t.index [:id_topic, :id_category]
    end
    execute "ALTER TABLE ut_test_quest ADD PRIMARY KEY (id_quest, id_db_quest);
             ALTER TABLE ut_test_quest ADD CONSTRAINT fk_quest_topic FOREIGN KEY (id_topic)
              REFERENCES ut_test_topic (id_topic) ON UPDATE NO ACTION ON DELETE CASCADE;
             ALTER TABLE ut_test_quest ADD CONSTRAINT fk_quest_category FOREIGN KEY (id_category)
              REFERENCES ut_test_category (id_category) ON UPDATE NO ACTION ON DELETE CASCADE;"
  end
  def down
    execute "ALTER TABLE ut_test_quest DROP CONSTRAINT fk_quest_topic;
             ALTER TABLE ut_test_quest DROP CONSTRAINT fk_quest_category;"
    drop_table :quest
  end
end