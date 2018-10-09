# frozen_string_literal: true

require 'dry/system/container'
require 'dry/system/hanami'
require_relative '../lib/types'
require_relative './settings'

# General container class for project dependencies
#
# {http://dry-rb.org/gems/dry-system/ Dry-system documentation}
class Container < Dry::System::Container
  extend Dry::System::Hanami::Resolver
  setting :settings

  # use :bootsnap
  use :env

  #  Core
  register_folder! 'core/repositories'
  register_folder! 'core/libs'

  # proposals
  register_folder! 'proposals/operations'

  # variants
  register_folder! 'variants/operations'

  # organisations
  register_folder! 'organisations/operations'

  # teams
  register_folder! 'teams/operations'

  # polls
  register_folder! 'polls/operations'


  configure do |config|
    config.env = Hanami.env
    config.settings = Settings.load(root, config.env)
  end

  def self.settings
    config.settings
  end

  # Combines a settings hash from keys prefixed with `scope` value
  # @param scope [#to_s]
  # @return [Hash{Symbol=>Object}]
  def self.settings_for(scope)
    hash = settings.to_hash
    prefix = /^#{Regexp.escape(scope.to_s)}_/
    hash.keys.grep(prefix).each_with_object({}) do |key, result|
      result[key.to_s.gsub(prefix, '').to_sym] = hash[key]
    end
  end
end
