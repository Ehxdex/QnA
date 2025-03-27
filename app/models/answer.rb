class Answer < ApplicationRecord
  belongs_to :author, class_name: "User"
  belongs_to :question

  has_many_attached :files

  validates :body, presence: true

  default_scope { order("best DESC") }

  def set_best
    self.class.transaction do
      question.answers.update_all(best: false)
      update(best: true)
    end
  end
end
