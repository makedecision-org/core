Hanami::Model.migration do
  change do
    create_table :polls do
      primary_key :id
      foreign_key :proposal_id, :proposals, on_delete: :cascade, null: false

      column :title,           String, null: false
      column :description,     String, text: true
      column :raw_description, String, text: true

      column :type,            String, null: false
      column :anonymous, TrueClass, default: false

      column :vote_data, :jsonb, default: '[]'

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
      column :closed_at, DateTime
    end
  end
end
