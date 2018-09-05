class TeamRepository < Hanami::Repository
  associations do
    belongs_to :organisation
    has_many :proposals
  end
end
