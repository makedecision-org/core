class ProposalRepository < Hanami::Repository
  associations do
    belongs_to :organisation
    belongs_to :team

    has_many :variants
    has_many :comments
  end

  def find_with_variants(id)
    aggregate(:variants, :comments, :team).where(id: id).map_to(Proposal).one
  end

  def grupped_by_status_for_team(team_id)
    root.where(team_id: team_id).map_to(Proposal).to_a.group_by(&:status)
  end
end
