class Quest < ActiveRecord::Base
# require 'rubygems'
# require 'composite_primary_keys'
#  set_primary_keys [:id_quest, :id_db_quest]
  self.primary_keys = :id_quest, :id_db_quest
  has_many :answs, :class_name => 'Answ', :foreign_key => [:id_quest, :iddb_quest]#, :primary_key => [:id_quest, :id_db_quest]
#  belongs_to :ticket, :class_name => 'Ticket', :foreign_key => [:id_quest, :id_db_quest]
end
