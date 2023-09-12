# == Schema Information
#
# Table name: slaves
#
#  id         :bigint           not null, primary key
#  name       :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  mesh_id    :bigint
#
# Indexes
#
#  index_slaves_on_mesh_id           (mesh_id)
#  index_slaves_on_mesh_id_and_name  (mesh_id,name) UNIQUE
#  index_slaves_on_name              (name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (mesh_id => meshes.id)
#
class Slave < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: {scope: :mesh, case_sensitive: false}

  has_many :pins
  belongs_to :mesh
end
