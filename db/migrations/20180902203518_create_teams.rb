Hanami::Model.migration do
  change do
    create_table :teams do
      primary_key :id

      foreign_key :organisation_id, :organisations, on_delete: :cascade, null: false

      column :title, String, null: false

      column :body,     String, text: true
      column :raw_body, String, text: true

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
