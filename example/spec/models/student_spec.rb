require 'rails_helper'

RSpec.describe Student, type: :model do

  describe 'valid student' do
    let!(:student) { Student.new(first_name: 'Dwayne', last_name: 'Johnson') }

    it 'is valid with a first name and last name' do
      expect(student).to be_valid
    end

    it "returns a user's full name as a string" do
      expect(student.to_s).to eq 'Dwayne Johnson'
    end
  end

  describe 'validations' do
    # uses shoulda-matchers to test validations
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name }
  end

end
