Hanami::Model.migration do
  change do
    alter_table :proposals do
      add_foreign_key :team_id, :teams, on_delete: :cascade, null: false
    end
  end
end