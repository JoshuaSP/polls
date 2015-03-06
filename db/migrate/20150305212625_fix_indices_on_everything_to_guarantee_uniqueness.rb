class FixIndicesOnEverythingToGuaranteeUniqueness < ActiveRecord::Migration
  def change
    remove_index :users, :name
    remove_index :polls, :title
    add_index :users, :name, unique: true
    add_index :polls, :title, unique: true
    add_index :questions, [:text, :poll_id], unique: true
    add_index :answer_choices, [:text, :question_id], unique: true
  end
end
