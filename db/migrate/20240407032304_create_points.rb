class CreatePoints < ActiveRecord::Migration[7.1]
  def change
    create_table :points do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :related_transaction_id, null: false
      t.decimal :points
      t.string :reason
      t.boolean :is_deleted,default: false
      t.timestamps
    end
  end
end
