class ApplicationController < ActionController::Base
  helper_method :current_user
  private
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
# helper_method :current_user ensures that it can be called from the views as well
