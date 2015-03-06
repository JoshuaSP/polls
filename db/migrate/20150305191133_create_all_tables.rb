class CreateAllTables < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, :unique
      t.timestamps
    end

    add_index :users, :name

    create_table :polls do |t|
      t.string :title, :unique
      t.integer :author_id
      t.timestamps
    end

    add_index :polls, :title

    create_table :questions do |t|
      t.string :text
      t.integer :poll_id
      t.timestamps
    end

    add_index :questions, :poll_id

    create_table :answer_choices do |t|
      t.string :text
      t.integer :question_id
      t.timestamps
    end

    add_index :answer_choices, :question_id

    create_table :responses do |t|
      t.integer :user_id
      t.integer :answer_choice_id
      t.timestamps
    end

    add_index :responses, :answer_choice_id
    add_index :responses, :user_id
  end
end
