class CreateKyoos < ActiveRecord::Migration[5.2]
  def change
    create_table :kyoos do |t|
      t.string :name

      t.timestamps
    end
  end
end
