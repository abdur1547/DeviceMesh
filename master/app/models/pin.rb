# == Schema Information
#
# Table name: pins
#
#  id         :bigint           not null, primary key
#  name       :string           default(""), not null
#  status     :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slave_id   :bigint
#
# Indexes
#
#  index_pins_on_slave_id           (slave_id)
#  index_pins_on_slave_id_and_name  (slave_id,name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (slave_id => slaves.id)
#
class Pin < ApplicationRecord
  ON = true
  OFF = false
  
  validates :name, presence: true
  validates :name, uniqueness: {scope: :slave, case_sensitive: false}
  validates :status, presence: true
  validates :status, inclusion: {in: [ON, OFF]}

  belongs_to :slave

  def on?
    status
  end

  def off?
    !status
  end
end
