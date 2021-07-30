class CreatePostThreads < ActiveRecord::Migration[6.1]
  def change
    create_table :post_threads do |t|
      t.text :content
      t.belongs_to :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
