class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :config_permitted_parameters, if: :devise_controller?

  before_action :process_notify, if: :devise_controller?

  protected
  	def config_permitted_parameters
  		devise_parameter_sanitizer.for(:sign_up).concat [:name, :gender, :age]
  		devise_parameter_sanitizer.for(:account_update).concat [:name, :gender, :age]
  	end

  	def process_notify
  		if (user_signed_in?)
  			@pending_invited = current_user.pending_invited_by
  			p @pending_invited
  		end
  	end
end
