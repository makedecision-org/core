Hanami::Model.migration do
  change do
    create_table :organisations do
      primary_key :id

      column :title,           String, null: false
      column :description,     String, text: true
      column :raw_description, String, text: true

      column :public, TrueClass, default: true

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
