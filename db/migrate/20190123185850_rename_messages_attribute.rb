class RenameMessagesAttribute < ActiveRecord::Migration[5.2]
  def change
    rename_column :messages, :message, :message_body
  end
end
