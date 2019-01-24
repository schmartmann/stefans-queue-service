class ChangeMessageBodyDataType < ActiveRecord::Migration[5.2]
  def change
    change_table :messages do |t|
      t.change :message_body, :text, default: '', null: false
    end
  end
end
