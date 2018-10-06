# frozen_string_literal: true

Hanami::Model.migration do
  change do
    alter_table :votes do
      add_foreign_key :account_id, :accounts, on_delete: :cascade, null: false
    end
  end
end
