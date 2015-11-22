 module ActivityLog
  def create_log object, user_id, type_of_activity
    object.activities.create! user_id: user_id, type_of_activity: type_of_activity
  end
end
