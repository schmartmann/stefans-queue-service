class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string     :uuid, null: false
      t.boolean    :read, null: false, default: false
      t.json       :message, null: false, default: {}
      t.references :kyoo, foreign_key: true

      t.timestamps
    end
  end
end
