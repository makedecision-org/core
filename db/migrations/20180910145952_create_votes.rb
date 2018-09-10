Hanami::Model.migration do
  change do
    create_table :votes do
      primary_key :id
      foreign_key :poll_id, :polls, on_delete: :cascade, null: false

      column :reason,     String, text: true
      column :raw_reason, String, text: true

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
