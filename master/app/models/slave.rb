# == Schema Information
#
# Table name: slaves
#
#  id         :bigint           not null, primary key
#  name       :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_slaves_on_name  (name) UNIQUE
#
class Slave < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :pins
end
