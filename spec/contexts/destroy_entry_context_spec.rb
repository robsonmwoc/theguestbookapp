require 'rails_helper'

RSpec.describe DestroyEntryContext, type: :context do
  describe 'Removing a missing entry' do
    let(:listener) { double(:FakeController) }
    let(:entry) { double(:Entry, destroy: false) }

    subject { described_class.new(1, listener) }

    context 'When successed' do
      it 'removes the entry' do
        allow(Entry).to receive(:find).and_return(entry)

        expect(entry).to receive(:destroy).and_return(true)
        expect(listener).to receive(:on_destroing_successed!)

        subject.execute
      end
    end

    context 'When fails' do
      it 'returns moved_permanently' do
        expect(listener).to receive(:on_destroing_failed_gone!)

        subject.execute
      end

      it 'returns a failure' do
        allow(Entry).to receive(:find).and_return(entry)
        expect(listener).to receive(:on_destroing_failed!)

        subject.execute
      end
    end
  end
end
