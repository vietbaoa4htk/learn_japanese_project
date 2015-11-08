class UsersController < ApplicationController
	before_action :authenticate_user!, only: [:add_friend]

  def index
  end

  def show
  	# redirect if request to current user
  	if (current_user && current_user.id.to_s == params[:id])
  		redirect_to :edit_user_registration
  	end

  	@user = User.find(params[:id])

  	@friend_state = nil
  	if (user_signed_in?)
  		if (current_user.friend_with? @user)
  			@friend_state = 'approved'
  		elsif (@user.invited_by? current_user)
  			@friend_state = 'pending'
  		elsif (current_user.blocked? @user)
  			@friend_state = 'blocked'
  		elsif (current_user.invited_by? @user)
  			@friend_state = 'approving'
  		else
  			@friend_state = 'available'
  		end
  	end
  end

  def add_friend
  	@user = User.find(params[:id])
  	current_user.invite(@user)

  	redirect_to :show_user, id: params[:id]
  end

  def remove_friend
  	@user = User.find(params[:id])
  	current_user.remove_friendship(@user)

  	redirect_to :show_user, id: params[:id]
  end

  def accept_friend
  	@user = User.find(params[:id])
  	re = current_user.approve(@user)
  	p re

  	redirect_to :show_user, id: params[:id]
  end

  def block_friend
  	@user = User.find(params[:id])
  	current_user.block(@user)

  	redirect_to :show_user, id: params[:id]
  end

  def unblock_friend
  	@user = User.find(params[:id])
  	current_user.unblock(@user)

  	redirect_to :show_user, id: params[:id]
  end
end
