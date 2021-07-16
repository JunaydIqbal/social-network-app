class CreatePosts < ActiveRecord::Migration[6.1]
  def up
    create_table :posts do |t|
      t.string :name
      t.string :title
      t.text :content
      t.datetime :publish_at

      t.timestamps
    end
  end

  def def down 
    drop_table :posts
  end
end
