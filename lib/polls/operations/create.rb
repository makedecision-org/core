# frozen_string_literal: true

module Polls
  module Operations
    class Create < Libs::Operation
      # include Import[]

      def call()
        Success(Poll.new)
      end
    end
  end
end
