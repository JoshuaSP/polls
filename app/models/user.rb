# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  unique     :string
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: :true

  has_many(
    :polls,
    class_name: :Poll,
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many(
    :responses,
    class_name: :Response,
    foreign_key: :user_id,
    primary_key: :id
  )

  def completed_polls
    my_answer_choices = responses.joins(:answer_choice).to_sql
    Poll
    .joins(:questions)
    .joins(my_answer_choices)
    .group('polls.id')
    .having('COUNT(questions.id) = COUNT(b.id)')
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
