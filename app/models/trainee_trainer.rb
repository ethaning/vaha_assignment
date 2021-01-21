# == Schema Information
#
# Table name: trainee_trainers
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  trainee_id :bigint           not null
#  trainer_id :bigint           not null
#
# Indexes
#
#  index_trainee_trainers_on_trainee_id  (trainee_id)
#  index_trainee_trainers_on_trainer_id  (trainer_id)
#
# Foreign Keys
#
#  fk_rails_...  (trainee_id => users.id)
#  fk_rails_...  (trainer_id => users.id)
#
class TraineeTrainer < ApplicationRecord
  belongs_to :trainee, class_name: "User"
  belongs_to :trainer, class_name: "User"
end
