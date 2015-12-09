class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, index: true
      t.text :body, null: false
      t.references :micropost, index: true

      t.timestamps
    end
  end
end
