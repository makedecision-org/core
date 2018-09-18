# frozen_string_literal: true

class ProposalRepository < Hanami::Repository
  relations :organisations, :teams, :variants, :comments, :polls, :poll_variants

  associations do
    belongs_to :organisation
    belongs_to :team

    has_many :variants
    has_many :comments
    has_many :polls
  end

  def find_with_variants(id)
    aggregate(:variants, :comments, :team, polls: :poll_variants).where(id: id).map_to(Proposal).one
  end

  def grupped_by_status_for_team(team_id)
    root.where(team_id: team_id).map_to(Proposal).to_a.group_by(&:status)
  end
end
