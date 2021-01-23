# == Schema Information
#
# Table name: expertises
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Expertise < ApplicationRecord
  has_many :trainers

  validates :name, presence: true, uniqueness: true

  def to_builder
    Jbuilder.new do |expertise|
      expertise.(self, *self.attributes.keys)
    end
  end
end
