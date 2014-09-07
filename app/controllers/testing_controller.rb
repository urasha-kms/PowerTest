class TestingController < ApplicationController
  #require "TestingHelper"
  #require 'rubygems'
  #require 'composite_primary_keys'
#  session[:answ_good]  массив правильных ответов
#  session[:answ_user]  массив ответов пользователя
#  session[:answ_result]   -1 неправильный ответ; 0 - нет ответа; 1 - правильный ответ 
#  session[timetest] = 20
  before_filter :show_change_topic_category_numticket, :only => [:show, :change_topic, :change_category, :change_numticket]
  before_filter :for_quest_answer, :only => [:change_quest, :accept_answer]
#  after_filter :for_all_action, :only => [:change_topic, :change_category, :change_numticket, :change_quest, :accept_answer]
#  after_filter :after_quest_answer, :only => [:change_quest, :accept_answer]
    
  def show
  end	
  
  def change_topic
  end  

  def change_category
  end  

  def change_numticket
  end  

  def change_quest
  end  

  def change_answer
    session[:answ_user][params[:quest_id].to_i - 1][params[:answ_id].to_i] = params[:answ_val].to_i
    respond_to do |format|
      format.js { }
    end
  end  

  def accept_answer
  end  

  private

  def show_change_topic_category_numticket
    if !signed_in?
      redirect_to root_url  
    end 
    @nameact = self.action_name
    id_topic = params[:topic_id].to_i
    case @nameact
    when 'show'
      @topic = Topic.all
#      @category = @topic.first.categoryes.order("id_category")
      @category = @topic[0].categoryes.select("ut_test_category.id_category, name").order("id_category")
      @numticket = get_numticket(@topic[0].id_topic, @category[0].id_category)
      @ticket = @numticket[0].tickets.order("num")
    when 'change_topic'
      @category = Topic.find(id_topic).categoryes.order("id_category") 
#      @numticket = get_numticket(id_topic, @category.first.id_category)
      @numticket = get_numticket(id_topic, @category[0].id_category)
      @ticket = @numticket.first.tickets.order("num")
#      @ticket = @numticket[0].tickets.order("num")
    when 'change_category'  
      @numticket = get_numticket(id_topic, params[:group_id].to_i)
#      @ticket = @numticket.first.tickets.order("num")
      @ticket = @numticket[0].tickets.order("num")
    when 'change_numticket'  
      @ticket = Ticket.where("id_numticket = ?", params[:ntic_id].to_i).order("num")
    end    
#    @quest = Quest.where("id_quest = ?", @ticket[0][:id_quest], "iddb_quest = ?", @ticket[0][:iddb_quest])
    @quest = Quest.where("id_quest = ? and id_db_quest = ?", @ticket[0][:id_quest], @ticket[0][:iddb_quest])[0]
    @answ = @quest.answs
    @quest_num = @ticket[0][:num]
    create_array_answ (@ticket)
    @answ_result = session[:answ_result]
    @curr_answer = session[:answ_user][0]
    @res_answ = 0
    @answ_all = false
    @percent_good_answ = get_percent_good_answer
    @id_ocenka = get_id_ocenka
    @timetest = get_timetest
    if @nameact != 'show'
      respond_to do |format|
        format.js { }
      end
    end  
  end  

  def for_quest_answer 
    @nameact = self.action_name
    @quest_num = params[:qst_id].to_i
#    @ticket = Ticket.where("id_numticket = ?", params[:ntic_id].to_i).order("num")
    @ticket = Ticket.where("id_numticket = ? and num = ?", params[:ntic_id].to_i, @quest_num)
#    @quest = Quest.find(@ticket.find_by_num(params[:qst_id].to_i).id_quest, @ticket.find_by_num(params[:qst_id].to_i).iddb_quest)
#    @quest = Quest.find(@ticket.first.id_quest, @ticket.first.iddb_quest)
#    @quest = Quest.find(@ticket[0][:id_quest], @ticket[0][:iddb_quest])
    @quest = Quest.where("id_quest = ? and id_db_quest = ?", @ticket[0][:id_quest], @ticket[0][:iddb_quest])[0]

    @answ = @quest.answs
#    @quest_num = @ticket.find_by_num(params[:qst_id].to_i).num
#    @curr_answer = session[:answ_user][params[:qst_id].to_i - 1]
    @curr_answer = session[:answ_user][@quest_num - 1]
    
    case @nameact
    when 'accept_answer'  
#      session[:answ_result][params[:qst_id].to_i - 1] = get_result(params[:qst_id].to_i - 1)
      session[:answ_result][@quest_num - 1] = get_result(@quest_num - 1)
      @answ_all = get_all_answer?
    end
    
    # debugger    

    @answ_result = session[:answ_result]
#    @res_answ = session[:answ_result][params[:qst_id].to_i - 1]
    @res_answ = session[:answ_result][@quest_num - 1]
    @solution_answ = get_solution_answ(@quest_num)
    @percent_good_answ = get_percent_good_answer
    @id_ocenka = get_id_ocenka
    @timetest = get_timetest

    respond_to do |format|
      format.js { }
    end
  end  

  def get_valid_answer?(num_quest)
    session[:answ_user][num_quest] == session[:answ_good][num_quest]
  end  

  def get_result(num_quest) 
    get_valid_answer?(num_quest) ? 1 : -1
  end  

  def create_array_answ (tick)
    session[:answ_good], session[:answ_user], session[:answ_result] = [], [], []
    tick.each do |t|
      session[:answ_good].push([])
      session[:answ_user].push([])
      session[:answ_result].push(0)
      get_answ(t.id_quest, t.iddb_quest).each {|a| session[:answ_user][t.num - 1].push(0); session[:answ_good][t.num - 1].push(a.good)}
    end
  end  

  def get_all_answer?
    !session[:answ_result].include?(0)
  end  

  def get_percent_good_answer
    100 * session[:answ_result].select{|x| x == 1}.size / session[:answ_result].size
  end  

  def get_id_ocenka
    case get_percent_good_answer
      when 100    
        1
      when 90..99 
        2
      when 80..89 
        3
      else 
        4
    end    
  end  

  def get_solution_answ(num_quest)
    r = []
    session[:answ_good][num_quest - 1].each_with_index {|el,ind| r<<(ind + 1) if el == 1}
    r.join(", ") 
  end

#  def get_timetest
#    if !session.has_key?(:timetest)
#      session[:timetest] = 20
#    else
#      if session[:timetest].nil? || session[:timetest] == 0
#        20
#     else
#        session[:timetest]
#      end
#    end
#  end
end