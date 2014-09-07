module TestingHelper

  def get_answ (id_quest, iddb_quest)
    #Quest.find(id_quest, iddb_quest).answs
     Answ.where("id_quest = ? and iddb_quest = ?", id_quest, iddb_quest)
  end 

  def get_numticket (id_topic, id_category)
    Numticket.select("id_numticket, nticket").where("id_topic = ? and id_category = ?", id_topic, id_category).order("nticket")
  end  
end
