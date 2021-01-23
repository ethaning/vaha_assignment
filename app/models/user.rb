# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  allow_password_change  :boolean          default(FALSE)
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  provider               :string           default("email"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  tokens                 :json
#  type                   :string
#  uid                    :string           default(""), not null
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  expertise_id           :bigint
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_expertise_id          (expertise_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (expertise_id => expertises.id)
#
class User < ApplicationRecord
  include DeviseTokenAuth::Concerns::User

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :first_name, :last_name, presence: true
  validates :password, confirmation: true
  validates :email, presence: true, length: { maximum: 255 }, format: { with: Devise.email_regexp },
                    uniqueness: { case_sensitive: false, scope: :provider }

  def trainer?
    type == "Trainer"
  end

  def trainee?
    type == "Trainee"
  end

  def to_builder
    Jbuilder.new do |user|
      user.(self, :first_name, :last_name, :email, :created_at, :type)
      user.expertise expertise.to_builder
    end
  end
end
