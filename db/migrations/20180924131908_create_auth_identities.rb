# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :auth_identities do
      primary_key :id
      foreign_key :account_id, :accounts, on_delete: :cascade

      column :uid,                 String
      column :token,               String
      column :type,                String

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
