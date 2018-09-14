# frozen_string_literal: true

require 'dry-types'

# Module with all project types
#
# {http://dry-rb.org/gems/dry-types/ Dry-types documentation}
module Types
  include Dry::Types.module

  ProposalStatuses = String.constructor(proc { |value| value.to_s.downcase })
                           .default('open')
                           .enum('open', 'approved', 'denied')

  PollTypes = String.constructor(proc { |value| value.to_s.downcase }).enum('multipy')
end
