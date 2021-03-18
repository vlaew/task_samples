class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.belongs_to :post, null: false, index: true
      t.belongs_to :user, null: false, index: true

      t.timestamps null: false
    end
  end
end
