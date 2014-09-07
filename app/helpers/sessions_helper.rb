module SessionsHelper
def get_timetest
  if !session.has_key?(:timetest)
    session[:timetest] = 20
  else
    if session[:timetest].nil? || session[:timetest] == 0
      20
    else
      session[:timetest]
    end
  end
end

def sign_in(user)
  remember_token = User.new_remember_token
  cookies[:remember_token] = { value: remember_token, expires: 1.days.from_now }
  user.update_attribute(:remember_token, User.encrypt(remember_token))
  user.update_attribute(:count_session, user.count_session + 1)
  self.current_user = user
end

def current_user=(user)
  @current_user = user
end

def current_user
  remember_token = User.encrypt(cookies[:remember_token])
  @current_user ||= User.find_by(remember_token: remember_token)
end

def signed_in?
  !current_user.nil?
end

def sign_out
  if !signed_in?
    return
  end  
  current_user.update_attribute(:remember_token, User.encrypt(User.new_remember_token))
  cookies.delete(:remember_token)
  self.current_user = nil
end

def user_admin?
#  get_valid_answer?(num_quest) ? 1 : -1
signed_in? ? current_user.admin == 1 : false 
#  if signed_in?
#    current_user.admin == 1 
#  else
#    false  
#  end
end


end
