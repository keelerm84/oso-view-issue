class CreatePostComments < ActiveRecord::Migration[7.0]
  def change
    create_table :post_comments do |t|
      t.string :comment
      t.integer :author_id
      t.integer :post_id

      t.timestamps
    end
  end
end
