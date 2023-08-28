# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string
#  full_name       :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true
  validates :email, uniqueness: true
  validates :full_name, presence: true
  validates :password, presence: true
  validates :password_digest, presence: true
  
  has_one :user_role, dependent: :destroy
  has_one :role, through: :user_role
  has_many :meshes, dependent: :destroy
end
