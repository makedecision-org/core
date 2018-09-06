# frozen_string_literal: true

Hanami::Model.migration do
  change do
    extension :pg_enum

    create_enum(:proposal_statuses, %w[open approved denied])

    create_table :proposals do
      primary_key :id

      column :title,    String, null: false
      column :body,     String, text: true
      column :raw_body, String, text: true

      column :conclusions, String, text: true
      column :raw_conclusions, String, text: true

      column :status, 'proposal_statuses', null: false, default: 'open'

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
