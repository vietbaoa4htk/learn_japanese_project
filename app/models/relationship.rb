class Relationship < ActiveRecord::Base
  include ActivityLog
  after_create :create_follow_log

  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  has_many :activities, as: :targetable

  validates :follower_id, presence: true
  validates :followed_id, presence: true

  def create_follow_log
    create_log self, self.follower_id, Settings.activity_type.follow_user
  end
end
