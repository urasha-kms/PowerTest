class Topic < ActiveRecord::Base
#  require 'composite_primary_keys'
#  attr_accessible :name, :short	

#  set_primary_keys [:id_topic]
#  self.primary_keys :id_topic
  self.primary_key = "id_topic"
  has_many :numtickets, #-> { order("nticket") }, 
  :class_name => "Numticket", :primary_key => "id_topic", 
           :foreign_key => "id_topic", :dependent => :destroy##, :order => "nticket ASC"
  has_many :categoryes, -> { uniq }, #{ select('distinct nticket, ut_test_category.id_category, name') }, 
  :through => :numtickets, :source => :category,# -> { uniq },
           :foreign_key => "id_category", :primary_key => "id_category"#, :uniq => true
#           -> { where("age < 30").order("name").uniq }
end
