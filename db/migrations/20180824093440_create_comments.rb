# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :comments do
      primary_key :id

      foreign_key :proposal_id, :proposals, on_delete: :cascade, null: false

      column :body,     String, text: true
      column :raw_body, String, text: true

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
