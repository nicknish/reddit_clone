class Post < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :comments, dependent: :destroy
  acts_as_votable

  def vote_status(user)
    vote = self.votes_for.find_by(voter_id: user.id) if user
    if vote
      return 'upvote' if vote.vote_flag
      return 'downvote'
    end
    return nil
  end

  def total_votes
    upvotes = self.votes_for.where(vote_flag: true).count
    downvotes = self.votes_for.where(vote_flag: false).count
    return upvotes-downvotes
  end
end
