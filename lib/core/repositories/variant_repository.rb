class VariantRepository < Hanami::Repository
  associations do
    belongs_to :proposal
  end

  def add_positive_trait(id, trait)
    variant = root.by_pk(id).one!
    update(id, positive_traits: variant.positive_traits + [{ value: trait }])
  end

  def add_negative_trait(id, trait)
    variant = root.by_pk(id).one!
    update(id, negative_traits: variant.negative_traits + [{ value: trait }])
  end
end
