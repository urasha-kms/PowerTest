class AdminController < ApplicationController
  def index
    @users = User.all.order('id_user')
    @userog = User.find(1)
    @user = User.first
#    @select_user = User.find(1)
  end

  def select_user
    @user = User.where('name =?', params[:user_name])[0] 
    respond_to do |format|
      format.js { }
    end
  end

  def update
    @user = User.find(params[:user][:id_user])
    if params.has_key?(:button)
        @users = User.all.order('id_user')
        @userog = User.find(1)
        render 'admin/index'
    else
      if @user.update_attributes(user_params)
#        flash[:success] = "Profile updated."
        @users = User.all.order('id_user')
        @userog = User.find(1)
        render 'admin/index'
      else
        @user = User.find(params[:user][:id_user])
        @users = User.all.order('id_user')
        @userog = User.find(1)
        render 'admin/index'
      end  
    end
  end

  def create_user
    redirect_to root_url
  end

  def edit_user
    redirect_to root_url
#    @select_user = User.where('name =?', params[:name])[0] 
#    @select_user.password =  params[:password]
#    @select_user.save
#    redirect_to root_url
  end

  def destroy_user

  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :password_digest, :admin, :date_start, :date_stop)
  end

end
