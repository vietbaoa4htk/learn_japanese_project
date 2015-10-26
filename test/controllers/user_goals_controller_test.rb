require 'test_helper'

class UserGoalsControllerTest < ActionController::TestCase
  setup do
    @user_goal = user_goals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_goals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_goal" do
    assert_difference('UserGoal.count') do
      post :create, user_goal: { deadline: @user_goal.deadline, number_of_words: @user_goal.number_of_words, user_id: @user_goal.user_id }
    end

    assert_redirected_to user_goal_path(assigns(:user_goal))
  end

  test "should show user_goal" do
    get :show, id: @user_goal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_goal
    assert_response :success
  end

  test "should update user_goal" do
    patch :update, id: @user_goal, user_goal: { deadline: @user_goal.deadline, number_of_words: @user_goal.number_of_words, user_id: @user_goal.user_id }
    assert_redirected_to user_goal_path(assigns(:user_goal))
  end

  test "should destroy user_goal" do
    assert_difference('UserGoal.count', -1) do
      delete :destroy, id: @user_goal
    end

    assert_redirected_to user_goals_path
  end
end
