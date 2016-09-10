class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :link_url
      t.text :body
      t.integer :vote_count

      t.timestamps
    end
  end
end
