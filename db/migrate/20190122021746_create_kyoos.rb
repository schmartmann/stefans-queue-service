class CreateKyoos < ActiveRecord::Migration[5.2]
  def change
    create_table :kyoos do |t|
      t.string :name
      t.references :message, foreign_key: true

      t.timestamps
    end
  end
end
