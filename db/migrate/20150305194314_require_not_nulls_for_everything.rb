class RequireNotNullsForEverything < ActiveRecord::Migration
  def change
    change_column_null :users, :name, false
    change_column_null :polls, :author_id, false
    change_column_null :questions, :poll_id, false
    change_column_null :questions, :text, false
    change_column_null :responses, :answer_choice_id, false
    change_column_null :responses, :user_id, false
    change_column_null :answer_choices, :text, false
    change_column_null :answer_choices, :question_id, false
    change_column :polls, :title, :string, null: false
  end
end
