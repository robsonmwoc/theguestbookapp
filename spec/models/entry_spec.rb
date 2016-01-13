require 'rails_helper'

RSpec.describe Entry, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:message) }
end
