module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, dependent: :destroy, as: :votable
  end

  def votes_result(object)
    object.votes.sum(&:value)
  end
end
