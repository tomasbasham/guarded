class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts, id: :uuid do |t|
      t.string :title
      t.text :body
      t.boolean :published
      t.belongs_to :user, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
