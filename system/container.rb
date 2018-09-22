# frozen_string_literal: true

require 'dry/system/container'
require 'dry/system/hanami'
require_relative '../lib/types'

# General container class for project dependencies
#
# {http://dry-rb.org/gems/dry-system/ Dry-system documentation}
class Container < Dry::System::Container
  extend Dry::System::Hanami::Resolver

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
  end
end
