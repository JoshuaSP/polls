# == Schema Information
#
# Table name: polls
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  unique     :string
#  author_id  :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Poll < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true

  belongs_to(
    :author,
    class_name: :User,
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many(
    :questions,
    class_name: :Question,
    foreign_key: :poll_id,
    primary_key: :id
  )
end
