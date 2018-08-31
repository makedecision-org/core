class Organisation < Hanami::Entity
  attributes do
    attribute :id, Types::Int

    attribute :title,           Types::String
    attribute :description,     Types::String
    attribute :raw_description, Types::String

    attribute :public, Types::Bool

    attribute :created_at, Types::Time
    attribute :updated_at, Types::Time
  end

  def public?
    !!public
  end
end
