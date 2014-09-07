class Ticket < ActiveRecord::Base
#  self.primary_key = [id_numticket, :id_quest, :iddb_quest
  self.primary_keys = :id_numticket, :id_quest, :iddb_quest

#  has_many :tickets, :class_name => "Ticket", :primary_key => "id_ticket", 
#           :foreign_key => "id_ticket"
#  has_many :quests, -> { uniq }, :through => :tickets, #:source => :quest, 
#           :foreign_key => [:id_quest, :id_db_quest]#, :primary_key => "id_category"

#  belongs_to :numticket, :class_name => "Numticket", :foreign_key => "id_numticket"
#  has_many :quests, :class_name => 'Quest', :foreign_key => [:id_quest, :id_db_quest]
#  default_scope :order => 'ut_test_ticket.num ASC'
end
