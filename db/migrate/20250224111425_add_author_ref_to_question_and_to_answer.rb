class AddAuthorRefToQuestionAndToAnswer < ActiveRecord::Migration[8.0]
  def change
    add_reference :questions, :author, foreign_key: { to_table: :users }, null: false
    add_reference :answers, :author, foreign_key: { to_table: :users }, null: false
  end
end
