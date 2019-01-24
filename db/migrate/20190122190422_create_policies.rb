class CreatePolicies < ActiveRecord::Migration[5.2]
  def change
    create_table :policies do |t|
      t.string     :uuid, null: false
      t.references :user, foreign_key: true
      t.references :kyoo, foreign_key: true
    end
  end
end
