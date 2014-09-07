class ApplicationController < ActionController::Base
  protect_from_forgery
  include TestingHelper
  include SessionsHelper

end
