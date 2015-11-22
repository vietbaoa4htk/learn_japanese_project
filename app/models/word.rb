class Word < ActiveRecord::Base
  belongs_to :category
  has_many :results
  has_many :answers
  has_many :lessons, through: :results

  scope :learned, ->(user, category){joins(:lessons).where(lessons: {user_id: user.id})
    .distinct.where.not results: {answer_id: nil}}
  scope :not_learn, ->(user, category){where.not id: category.words.learned(user, category)}
  scope :all_word, ->(user, category){}

  accepts_nested_attributes_for :answers,
    reject_if: ->attributes{attributes["content"].blank?},
    allow_destroy: true
end
