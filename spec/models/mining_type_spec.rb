require 'rails_helper'
RSpec.describe MiningType, type: :model do
  let(:mining_type) {FactoryBot.create :mining_type}
  subject{ mining_type}

  describe 'associations' do
    it {is_expected.to have_many(:coins)}

  end

  describe 'Validations' do
    it{ is_expected.to validate_presence_of(:description)}
    it{ is_expected.to validate_presence_of(:acronym)}

    it 'é válido' do
      expect(mining_type).to be_valid
    end
  end

end