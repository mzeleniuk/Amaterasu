class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :commenter, null: false
      t.text :body, null: false
      t.references :micropost, index: true

      t.timestamps
    end
  end
end
