require 'rails_helper'

RSpec.describe Borrowing, type: :model do
  describe "validations" do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:book) }
    # Add more validations as needed
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:book) }
    # Add more associations as needed
  end

  # Add any additional model-specific tests
end
