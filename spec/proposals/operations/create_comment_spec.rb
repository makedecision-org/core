RSpec.describe Proposals::Operations::CreateComment, type: :operation do
  include Dry::Monads::Result::Mixin

  let(:operation) { described_class.new(comment_repository: comment_repository) }
  let(:comment_repository) { double(:comment_repository, create: Comment.new) }

  subject { operation.call(proposal_id: 1, body: 'new **comment** here') }

  context 'when data valid' do
    it 'creates a new comment for the proposal' do
      expect(comment_repository).to receive(:create).with(
        body: "<p>new <strong>comment</strong> here</p>\n", raw_body: 'new **comment** here', proposal_id: 1
      ).and_return(Comment.new)

      expect(subject).to eq Success(Comment.new)
    end
  end

  context 'whis real dependencies' do
    let(:operation) { described_class.new }
    let(:proposal) { Fabricate.create(:proposal) }

    subject { operation.call(proposal_id: proposal.id, body: 'new comment here') }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to be_a Comment }
  end
end
