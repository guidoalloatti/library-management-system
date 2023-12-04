require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:author) }
    it { should validate_presence_of(:genre) }
    it { should validate_presence_of(:isbn) }
    it { should validate_presence_of(:total_copies) }
  end

  describe "associations" do
    it { should have_many(:borrowings) }
  end

  # TODO
  # Fix and add any additional model-specific tests
end