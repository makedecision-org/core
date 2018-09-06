# frozen_string_literal: true

module Proposals
  module Operations
    class UpdateStatus < Libs::Operation
      include Import[proposal_repository: 'repositories.proposal']

      ALLOWED_STATUSES = [Proposal::APPROVED, Proposal::DENIED].freeze

      def call(id:, **payload)
        payload = payload.slice(:status, :conclusions)

        if ALLOWED_STATUSES.include?(payload[:status].to_s)
          # TODO: what will happend if id is not exist?
          proposal_repository.update(id, payload)
        end

        Success(id)
      end
    end
  end
end
