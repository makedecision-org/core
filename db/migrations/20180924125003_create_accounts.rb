# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :accounts do
      primary_key :id

      column :name,       String
      column :uuid,       String
      column :login,      String
      column :email,      String
      column :avatar_url, String
      column :bio,        String, text: true
      column :role,       String, default: 'user'

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
