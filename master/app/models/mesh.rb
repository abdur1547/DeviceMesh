# == Schema Information
#
# Table name: meshes
#
#  id         :bigint           not null, primary key
#  name       :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_meshes_on_user_id           (user_id)
#  index_meshes_on_user_id_and_name  (user_id,name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Mesh < ApplicationRecord
  validates :name, presence: true
  
  belongs_to :user
  has_many :slaves, class_name: 'Slave', dependent: :destroy
end
