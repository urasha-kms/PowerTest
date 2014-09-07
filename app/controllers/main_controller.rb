class MainController < ApplicationController
  def show
  end
  def index
    @timetest = session[:timetest].nil? ? 20 : session[:timetest]
    @timetest = get_timetest
  end
  def about
  end
  def group
  end
  def download
  end
  def setup
#    $MinTesting = params[:timetest].to_i
    session[:timetest] = params[:timetest].to_i
    redirect_to root_url
  end

end
