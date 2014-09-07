class Numticket < ActiveRecord::Base
  self.primary_key = "id_numticket"
  belongs_to :topic, :class_name => "Topic", :foreign_key => "id_topic", :primary_key => "id_topic"
  belongs_to :category, :class_name => "Category", :foreign_key => "id_category", :primary_key => "id_category"
  has_many :tickets, -> { order("num") }, :class_name => "Ticket", :primary_key => "id_numticket", 
           :foreign_key => "id_numticket", :dependent => :destroy#, :order => "num ASC"
#  has_many :answs, -> { uniq }, :through => :tickets,# :source => :answ, 
#           :foreign_key => [:id_quest, :iddb_quest], :primary_key => [:id_quest, :iddb_quest]#, :uniq => true
          
#  default_scope :order => 'ut_test_numticket.nticket ASC'

end
