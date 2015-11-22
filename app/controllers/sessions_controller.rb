class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      if user.blocked?
        flash.now[:danger] = t "controllers.sessions.create.flash_danger_blocked",
          time: user.blocked_at
        render :new
      else
        log_in user
        params[:session][:remember_me] == Settings.session.number ? remember(user) : forget(user)
        redirect_back_or user
      end
    else
      flash.now[:danger] = t "controllers.sessions.create.flash_danger"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
