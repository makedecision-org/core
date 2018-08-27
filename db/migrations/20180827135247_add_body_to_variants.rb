Hanami::Model.migration do
  change do
    add_column :variants, :body, String, text: true
    add_column :variants, :raw_body, String, text: true
  end
end
