# == Schema Information
#
# Table name: users
#
#  id           :bigint           not null, primary key
#  email        :string
#  first_name   :string
#  last_name    :string
#  type         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  expertise_id :bigint
#
# Indexes
#
#  index_users_on_expertise_id  (expertise_id)
#
# Foreign Keys
#
#  fk_rails_...  (expertise_id => expertises.id)
#
class Trainer < User
  belongs_to :expertise

  has_many :trainee_trainers
  has_many :trainees, through: :trainee_trainer
end
