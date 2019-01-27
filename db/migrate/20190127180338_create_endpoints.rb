class CreateEndpoints < ActiveRecord::Migration[5.2]
  def change
    create_table :endpoints do |t|
      t.string      :uuid, null: false
      t.string      :callback_url, null: false
      t.references  :subscription, foreign_key: true
      t.timestamps
    end
  end
end
