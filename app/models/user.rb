class User < ApplicationRecord
  include UUID
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JWTBlacklist

  validates :email,
            presence: true,
            uniqueness: true

  validates :password,
            presence: true,
            length: { minimum: 8 }

  has_many :policies
  has_many :kyoos, through: :policies
end
