# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  answer_choice_id :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#

class Response < ActiveRecord::Base
  validate :respondant_can_only_answer_question_once, :poll_author_cant_respond_to_own_poll

  belongs_to(
    :answer_choice,
    class_name: :AnswerChoice,
    foreign_key: :answer_choice_id,
    primary_key: :id
  )

  belongs_to(
    :user,
    class_name: :User,
    foreign_key: :user_id,
    primary_key: :id
  )

  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )

  has_one(
    :poll_author,
    through: :answer_choice,
    source: :poll_author
  )

  def sibling_responses
    if self.id
      question.responses.where('responses.id != ?', self.id)   # For my question what are all the responses?
    else
      question.responses
    end
  end

  def respondant_can_only_answer_question_once
    unless self.sibling_responses.where('responses.user_id = ?', self.user_id).empty?
      errors[:user] << "can't respond to a question twice"
    end
  end

  def poll_author_cant_respond_to_own_poll
    if self.user_id == poll_author.id
      errors[:user] << "can't respond to their own poll"
    end
  end
end
