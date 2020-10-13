class ApplicationController < ActionController::Base

    helper_method :current_user #lets us use this in our views

    def current_user
        @user ||= User.find_by(session_token: session[:session_token])
    end

    def login!(user)
        #I want to verify we have someone in our database that matches the user passed in.
        session[:session_token] = user.reset_session_token!
        # user == User.find_by_credentials(
        #     params[:user][:username],
        #     params[:user][:password]
        # )
        # if user
        #     session[:session_token] = user.reset_session_token!
        #     redirect_to cats_url
        # end
    end
end
