# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :vote_choices do
      primary_key :id

      foreign_key :vote_id,         :votes,         on_delete: :cascade, null: false
      foreign_key :poll_variant_id, :poll_variants, on_delete: :cascade, null: false

      column :score, Integer, default: 1, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
