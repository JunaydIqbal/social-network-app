class CreatePosts < ActiveRecord::Migration[6.1]
  def up
    change_table :posts do |t|
      # t.string :name
      # t.string :title
      # t.text :content
      #t.datetime :publish_at
      
      t.remove :publish_at
      #t.timestamps
    end
    add_column :posts, :published, :boolean, :default => false
    
  end

  def def down 
    drop_table :posts
  end
end
