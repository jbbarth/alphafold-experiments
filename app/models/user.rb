# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  provider   :string
#  uid        :string
#  name       :string
#  email      :string
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true, uniqueness: true

  def self.from_omniauth(omniauth_params)
    provider = omniauth_params.provider
    email = omniauth_params.email
    user = User.find_by(provider: provider, email: omniauth_params.info.email)

    return if !user

    user.email = omniauth_params.info.email
    user.name = omniauth_params.info.name
    user.image = omniauth_params.info.image
    user.uid = omniauth_params.uid
    user.save!

    user
  end
end
