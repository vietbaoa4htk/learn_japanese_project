class Answer < ActiveRecord::Base
  belongs_to :word

  has_many :results

  scope :suffer, ->{order "RANDOM()"}
  scope :correct, ->{where(is_correct: true).first}
end
