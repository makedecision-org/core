# frozen_string_literal: true

require_relative 'hanami_settings'

class Settings < Dry::System::Hanami::Settings
  setting :database_url, Types::Required::String.default('postgres://test@db/test')

  setting :dependency_base_url, Types::Required::String.default('url')
  setting :dependency_something_else, Types::Required::String.default('something else')
end
