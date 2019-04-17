class SessionsController < ApplicationController
  def create
    begin
      @user = User.from_omniauth request.env['omniauth.auth']
      session[:user_id] = @user.id
      flash[:success] = "Welcome, #{@user.name}!"
    rescue
      flash[:warning] = "There was an error while trying to authenticate you..."
    end
    redirect_to root_path
    # request.env['omniauth.auth'] contains the authentication hash with all the data about a user.
  end

  def destroy
    if current_user
      session.delete(:user_id)
      flash[:success] = 'See you!'
    end
    redirect_to root_path
  end
end
# The create method inside this controller will parse the user data, save it into the database and perform sign into the app. However, what does the user data look like?. That's easy to check.
# Just put binding.pry in the create action to see how the request.evn['omniauth.auth'] looks like. Now that you know what the authentication hash looks like and what data can be fetched, it's time to decide which information to store. Since we want to craft multi-provider authentication, saving something like tweets count is not the top priority.(however, you could just serialize and save the 'extra' part of user's authentication hash in a separate field.)
# from_omniauth is a yet non-existent method that will parse the authentication hash and return the user record. Next, just save the user's id inside the sessions and redirect to the main page. The from_omniauth method is written in the user.rb file