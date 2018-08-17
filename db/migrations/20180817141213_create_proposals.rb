Hanami::Model.migration do
  change do
    create_table :proposals do
      primary_key :id

      column :title, String, null: false
      column :body,  String, text: true

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
