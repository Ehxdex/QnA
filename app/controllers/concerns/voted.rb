module Voted
  extended ActiveSupport::Concern

  def vote_up
    set_votable
    @vote.set_vote_up
  end

  def vote_down
    set_votable
    @vote.set_vote_down
  end

  private

  def model_klass
    controller_name.classify.constantize
  end

  def set_votable
    @votable = model_klass.find(params[:id])
    @vote = Vote.new(user: current_user, votable: @votable)
  end
end
