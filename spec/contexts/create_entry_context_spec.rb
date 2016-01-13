require 'rails_helper'

RSpec.describe CreateEntryContext, type: :context do
  describe 'Removing a missing entry' do
    let(:listener) { double(:FakeController) }
    let(:entry) { double(:Entry, save: false) }

    subject { described_class.new({}, listener) }

    before do
      allow(entry).to receive(:valid?)
    end

    context 'When successed' do
      it 'creates an entry' do
        allow(Entry).to receive(:new).and_return(entry)

        expect(entry).to receive(:valid?).and_return(true)
        expect(entry).to receive(:save).and_return(true)
        expect(listener).to receive(:on_creation_successed!)

        subject.execute
      end
    end

    context 'When fails' do
      it 'returns a failure' do
        allow(Entry).to receive(:new).and_return(entry)
        expect(listener).to receive(:on_creation_failed!)

        subject.execute
      end
    end
  end
end
