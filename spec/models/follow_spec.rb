require 'rails_helper'

RSpec.describe Follow, type: :model do

  describe 'associations' do
    it { should belong_to(:follower).class_name('User') }
    it { should belong_to(:following).class_name('User') }
  end

  describe 'validations' do
    it { should validate_presence_of(:follower_id) }
    it { should validate_presence_of(:following_id) }
    it { should validate_presence_of(:status) }
    it { should define_enum_for(:status).with_values(pending: 0, accepted: 1) }
  end

  # describe 'enums' do
  #   it 'should have enum status with two states pending and accepted' do
  #     expect(Follow.statuses).to eq({ "pending" => 0, "accepted" => 1 })
  #   end
  # end
end
