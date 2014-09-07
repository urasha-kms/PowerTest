class Category < ActiveRecord::Base
  self.primary_key = "id_category"	
  has_many :numtickets, -> { order("nticket") }, :class_name => "Numticket", :primary_key => "id_category", 
           :foreign_key => "id_category", :dependent => :destroy#, :order => "nticket ASC"
end
