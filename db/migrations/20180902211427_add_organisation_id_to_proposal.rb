Hanami::Model.migration do
  change do
    alter_table :proposals do
      add_foreign_key :organisation_id, :organisations, on_delete: :cascade, null: false
    end
  end
end
