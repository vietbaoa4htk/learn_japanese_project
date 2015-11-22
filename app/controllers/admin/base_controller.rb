class Admin::BaseController < ApplicationController
  before_action :verify_admin

  private
  def verify_admin
    unless current_user.admin?
      flash[:danger] = t "controllers.application.verify_admin"
      redirect_to root_path
    end
  end
end
