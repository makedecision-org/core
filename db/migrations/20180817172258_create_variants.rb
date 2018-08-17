Hanami::Model.migration do
  change do
    create_table :variants do
      primary_key :id

      foreign_key :proposal_id, :proposals, on_delete: :cascade, null: false

      column :name, String, null: false

      column :positive_traits, :jsonb, default: '[]'
      column :negative_traits, :jsonb, default: '[]'

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
