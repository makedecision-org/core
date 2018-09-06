# frozen_string_literal: true

class CommentRepository < Hanami::Repository
  associations do
    belongs_to :proposal
  end
end
