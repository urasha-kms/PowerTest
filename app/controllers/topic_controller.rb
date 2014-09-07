class TopicController < ApplicationController
  def new
    @topic = Topic.new
  end
  def create
    @topic = Topic.new(topic_params)
    @topic.save
    @topic = Topic.all
    render 'topic/show'
   #redirect_to :action => :show
  end
  def show
     @topic = Topic.all
  end
  def edit
    @topic = Topic.find(params[:id])
  end
  def update
    @topic = Topic.find(params[:id])
    @topic.update_attributes(topic_params)
    redirect_to :action => :show
  end


  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    redirect_to :action => :show
  end
  
  private

  def topic_params
    params.require(:topic).permit(:name, :short)
  end
end
