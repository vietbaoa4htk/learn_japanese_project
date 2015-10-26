class UserGoalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_goal, only: [:show, :edit, :update, :destroy]

  # GET /user_goals
  # GET /user_goals.json
  def index
    @user_goals = current_user.user_goals    
  end

  # GET /user_goals/1
  # GET /user_goals/1.json
  def show
    learned_logs = UserLog.where("log_data LIKE ?",'%learned % word%').select('log_data', 'created_at')
    @learned_words = 0
    p learned_logs.class.name
    learned_logs.each do |m|
      match = m.log_data.to_s.match('learned (\d+) word')
      if match
        @learned_words += match[1].to_i
        m.log_data = match[1].to_i
      end
    end  

    print learned_logs.all().select('cast(log_data as integer) as log_new').to_a

    @remaining_words = @user_goal.number_of_words > @learned_words ? @user_goal.number_of_words - @learned_words : 0
    now = Time.now
    @days_left = @user_goal.deadline > now ? (@user_goal.deadline - now)/1.day : 0
    @chart_data = learned_logs.group_by_day(:created_at, 'sum', 'cast(log_data as integer)')
    p @chart_data
  end

  # GET /user_goals/new
  def new
    @user_goal = UserGoal.new
  end

  # GET /user_goals/1/edit
  def edit
  end

  # POST /user_goals
  # POST /user_goals.json
  def create
    @user_goal = UserGoal.new(user_goal_params)
    @user_goal.user_id = current_user.id

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

  # PATCH/PUT /user_goals/1
  # PATCH/PUT /user_goals/1.json
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

  # DELETE /user_goals/1
  # DELETE /user_goals/1.json
  def destroy
    @user_goal.destroy
    respond_to do |format|
      format.html { redirect_to user_goals_url, notice: 'User goal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_goal
      @user_goal = UserGoal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_goal_params
      params.require(:user_goal).permit(:user_id, :number_of_words, :deadline)
    end
end
