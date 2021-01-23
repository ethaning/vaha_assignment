# == Schema Information
#
# Table name: expertises
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Expertise, type: :model do
  subject { build :expertise }

  context "relations" do
    it { should have_many(:trainers) }
  end

  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end
end
