class Vote < ApplicationRecord
  belongs_to :votable, polymorphic: true
  belongs_to :user

  validates :value, presence: true

  def set_vote_up
    update(value: 1)
  end

  def set_vote_down
    update(value: -1)
  end
end
