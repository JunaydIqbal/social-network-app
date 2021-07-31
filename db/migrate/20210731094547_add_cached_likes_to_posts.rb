class AddCachedLikesToPosts < ActiveRecord::Migration[6.1]
  def up
    change_table :posts do |t|
      t.remove :cached_votes_total
      t.remove :cached_votes_score
      t.remove :cached_votes_up
      t.remove :cached_votes_down
      t.remove :cached_weighted_score
      t.remove :cached_weighted_total
      t.remove :cached_weighted_average
    end

    # Uncomment this line to force caching of existing votes
    # Post.find_each(&:update_cached_votes)
  end

  def def down 
  
  end
end
