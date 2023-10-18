class AddAnswerToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :answer, :text
    add_column :questions, :author_id, :integer
  end
end
