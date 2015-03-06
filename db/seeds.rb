# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

  User.destroy_all
  Poll.destroy_all
  Question.destroy_all
  AnswerChoice.destroy_all
  Response.destroy_all

  user1 = User.create!(name: "Josh")
  user2 = User.create!(name: "Rayyan")
  user3 = User.create!(name: "Jack")

  poll1 = Poll.create!(title: "Programming Languages", author_id: user1.id)

  fav = Question.create!(text: "What's your favorite Language?", poll_id: poll1.id)
  l_fav = Question.create!(text: "What's your least favorite Language?", poll_id: poll1.id)

  f_ac1 = AnswerChoice.create!(text: "Ruby", question_id: fav.id)
  f_ac2 = AnswerChoice.create!(text: "JavaScript", question_id: fav.id)
  f_ac3 = AnswerChoice.create!(text: "Java", question_id: fav.id)
  f_ac4 = AnswerChoice.create!(text: "C", question_id: fav.id)
  lf_ac1 = AnswerChoice.create!(text: "Javascript", question_id: l_fav.id)
  lf_ac2 = AnswerChoice.create!(text: "C", question_id: l_fav.id)
  lf_ac3 = AnswerChoice.create!(text: "Java", question_id: l_fav.id)

  resp1 = Response.create!(user_id: user2.id, answer_choice_id: f_ac1.id)
  resp2 = Response.create!(user_id: user2.id, answer_choice_id: lf_ac2.id)
  resp5 = Response.create!(user_id: user3.id, answer_choice_id: f_ac1.id)
  resp6 = Response.create!(user_id: user3.id, answer_choice_id: lf_ac1.id)
