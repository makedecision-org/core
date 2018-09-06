# frozen_string_literal: true

RSpec.describe Web::Views::Proposals::New, type: :view do
  let(:exposures) { Hash[format: :html, teams: []] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/proposals/new.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #format' do
    expect(view.format).to eq exposures.fetch(:format)
  end
end
