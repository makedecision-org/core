Hanami::Model.migration do
  change do
    create_table :poll_variants do
      primary_key :id
      foreign_key :poll_id, :polls, on_delete: :cascade, null: false

      column :title,    String, null: false
      column :prioroty, Integer, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
