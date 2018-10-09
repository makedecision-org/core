# frozen_string_literal: true

require 'dotenv'

class Dry::System::Hanami::Settings
  SettingValueError = Class.new(StandardError)

  module Types
    include Dry::Types.module

    module Required
      String = Types::Strict::String.constrained(min_size: 1)
    end

    module Optional
      String = Required::String.optional
    end
  end

  def self.warn_generated(setting, value)
    env = setting.to_s.upcase
    ENV[env] = value
    warn <<~ERROR
        Please, set #{env} in `.env`:

            #{env}=#{value.inspect}

    ERROR
    value
  end

  def self.schema
    @schema ||= {}
  end

  def self.setting(name, type = nil)
    settings(name => type)
  end

  def self.settings(new_schema)
    check_schema_duplication(new_schema)
    @schema = schema.merge(new_schema)

    self
  end

  def self.check_schema_duplication(new_schema)
    shared_keys = new_schema.keys & schema.keys

    raise ArgumentError, "Setting :#{shared_keys.first} has already been defined" if shared_keys.any?
  end
  private_class_method :check_schema_duplication

  def self.load(root, env)
    build_config(schema, dotenv_data(root, env))
  end

  # @param [Settings] schema
  # @param [Hash] defaults
  # @return [Dry::Configurable::Config]
  def self.build_config(schema, defaults = {})
    Class.new do
      extend Dry::Configurable

      schema.each do |key, type|
        env_var = key.to_s.upcase
        value = ENV.fetch(env_var) { defaults[env_var] }

        begin
          value = type[value] if type
        rescue StandardError => e
          raise SettingValueError, "error typecasting +#{key}+: #{e}"
        end

        setting key, value
      end
    end.config
  end
end
