class TeamRepository < Hanami::Repository
  associations do
    belongs_to :organisation
  end
end
