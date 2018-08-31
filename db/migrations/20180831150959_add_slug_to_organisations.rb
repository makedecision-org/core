Hanami::Model.migration do
  change do
    add_column :organisations, :slug, String, null: false
  end
end
