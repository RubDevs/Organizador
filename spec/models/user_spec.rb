require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_timestamps }
  it { is_expected.to have_field(:email).of_type(String) }
  it { is_expected.to have_field(:encrypted_password).of_type(String) }
  it { is_expected.to have_many(:owned_tasks) }
  it { is_expected.to have_many(:participations) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_uniqueness_of(:email) }
  
  context 'with params from factory bot' do
    subject(:user){build :user}
    it 'is persisted' do
      expect(user.save).to eq true
    end
  end
end
