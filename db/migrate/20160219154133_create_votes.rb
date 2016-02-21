class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.belongs_to :votable, polymorphic: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :votes, :users
    add_index :votes, [:votable_id, :votable_type]
  end
end
