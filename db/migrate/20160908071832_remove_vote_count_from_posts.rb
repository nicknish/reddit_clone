class RemoveVoteCountFromPosts < ActiveRecord::Migration[5.0]
  def change
    remove_column :posts, :vote_count
  end
end
