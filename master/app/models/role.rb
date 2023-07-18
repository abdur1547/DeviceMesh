# == Schema Information
#
# Table name: roles
#
#  id         :bigint           not null, primary key
#  name       :string           default("normal"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_roles_on_name  (name) UNIQUE
#
class Role < ApplicationRecord
  ADMIN = 'admin'
  NORMAL = 'normal'
  
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, inclusion: {in: [ADMIN, NORMAL]}

  has_many :user_roles
  has_many :users, through: :user_roles
end
