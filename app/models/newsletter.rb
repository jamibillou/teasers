# == Schema Information
#
# Table name: newsletters
#
#  id         :integer          not null, primary key
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  from       :string(255)
#

class Newsletter < ActiveRecord::Base
  attr_accessible :email, :from

  validates :email, presence: true, email_format: true
  validates :from,  presence: true
  validates_uniqueness_of :email, scope: :from

end
