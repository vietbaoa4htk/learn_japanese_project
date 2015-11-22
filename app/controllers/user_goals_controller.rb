class UserGoalsController < ApplicationController
  before_action :logged_in_user
  before_action :set_user_goal, only: [:show, :edit, :update, :destroy]

  def index
    @user_goals = UserGoal.all
    @word_goals = current_user.user_goals
    @user_logs = UserLog.all
    @word_logs = current_user.user_logs
  end

  def show
  end

  def new
    @user_goal = UserGoal.new
  end

  def edit    
  end

  def create
    @user_goal = current_user.user_goals.build
    @user_goal.number_of_words = user_goal_params[:number_of_words]
    @user_goal.deadline = DateTime.strptime(user_goal_params[:deadline], '%m/%d/%Y')
    respond_to do |format|
      if @user_goal.save
        format.html { redirect_to @user_goal, notice: 'User goal was successfully created.' }
        format.json { render :show, status: :created, location: @user_goal }
      else
        format.html { render :new }
        format.json { render json: @user_goal.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user_goal.update(user_goal_params)
        format.html { redirect_to @user_goal, notice: 'User goal was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_goal }
      else
        format.html { render :edit }
        format.json { render json: @user_goal.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user_goal.destroy
    respond_to do |format|
      format.html { redirect_to user_goals_url, notice: 'User goal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_user_goal
      @user_goal = UserGoal.find(params[:id])
    end

    def user_goal_params
      params.require(:user_goal).permit(:number_of_words, :deadline)
    end

end
