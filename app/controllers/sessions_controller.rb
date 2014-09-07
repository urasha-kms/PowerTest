class SessionsController < ApplicationController
  def new

  end

  def create
#    if cookies[:remember_token].has_key?(:value)
#      redirect_to root_url
#    end  
#
    if params.has_key?(:button)
      redirect_to root_url
    else  
      user = User.find_by(name: params[:session][:name].downcase)
      if user && user.authenticate(params[:session][:password])
        # Sign the user in and redirect to the user's show page.
        #sign_in user
        #redirect_back_or user
        flash.now[:error] = 'Все хорошо'
#      redirect_to(request.env["HTTP_REFERER"])

        sign_in(user)
        redirect_to root_url
      else
        flash.now[:error] = 'Invalid email/password combination'
        render 'new'	
      # Create an error message and re-render the signin form.
      end  	
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

end
