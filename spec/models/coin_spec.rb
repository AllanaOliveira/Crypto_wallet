require 'rails_helper'
RSpec.describe Coin, type: :model do
  describe 'Validations' do
    let(:coin) { FactoryBot.create :coin}
    subject{ :coin }

    it{ is_expected.to validate_presence_of(:description)}
    it{ is_expected.to validate_presence_of(:acronym)}
    it{ is_expected.to validate_presence_of(:url_image)}

    it 'é válido' do
      expect(:coin).to be_valid
    end
  end
end

