class ChangeColumnTypeQuestionBody < ActiveRecord::Migration[8.0]
  def change
    change_column :questions, :body, :text
  end
end
