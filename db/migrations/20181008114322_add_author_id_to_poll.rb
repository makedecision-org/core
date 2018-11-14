# frozen_string_literal: true

Hanami::Model.migration do
  change do
    alter_table :polls do
      add_column :author_id, Integer, null: false
    end
  end
end
