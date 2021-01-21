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
require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
