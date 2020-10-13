#how are we supposed to update the session hash?
#how do session tokens come in?
#like params they come in with a request, but alongside it and not in it.

class SessionsController < ApplicationController

    before_action :ensure_logged_in, only: [:new, :create]

    def new
        render :new
    end

    def create
        # find a user by their username and password
        @user = User.find_by_credentials(
            params[:users][:username],
            params[:users][:password]
        )
        if @user
            login!(@user)
            redirect_to cats_url
        end

    end

    def destroy
        if current_user
            current_user.reset_session_token!
            session[:session_token] = nil
        end
    end
end