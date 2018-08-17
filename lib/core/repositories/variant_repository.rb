class VariantRepository < Hanami::Repository
  associations do
    belongs_to :proposal
  end
end
