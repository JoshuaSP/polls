# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  text       :string           not null
#  poll_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime




class Question < ActiveRecord::Base
  validates :text, uniqueness: { scope: :poll_id }

  belongs_to(
    :poll,
    class_name: :Poll,
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :answer_choices,
    class_name: :AnswerChoice,
    foreign_key: :question_id,
    primary_key: :id
  )

  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )

  has_one(
    :poll_author,
    through: :poll,
    source: :author
  )

  def results
    results = {}
    answer_choices
    .select('answer_choices.*, COUNT(responses.id) AS num_resps')
    .joins('LEFT OUTER JOIN responses ON responses.answer_choice_id
                      = answer_choices.id')
    .group('answer_choices.id')
    .each do |answer_choice|
      results[answer_choice.text] = answer_choice.num_resps
    end
    results
  end
end


# SELECT
#   polls.*, COUNT(questions.id), COUNT(b.id)
# FROM
#   polls
# JOIN
#   questions ON questions.poll_id = polls.id
# LEFT OUTER JOIN (
#   SELECT
#     answer_choices.id as id, answer_choices.question_id as question_id
#   FROM
#     responses
#   JOIN
#     answer_choices on responses.answer_choice_id = answer_choices.id
#   WHERE
#     responses.user_id = 11
# ) AS b ON b.question_id = questions.id
# GROUP BY
#   polls.id
# HAVING
#   COUNT(questions.id) = COUNT(b.id)
