class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.string      :uuid, null: false
      t.references  :user, foreign_key: true
      t.references  :kyoo, foreign_key: true
      t.timestamps
    end
  end
end
