# == Schema Information
#
# Table name: newsletters
#
#  id         :integer          not null, primary key
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Newsletter < ActiveRecord::Base
  attr_accessible :email

  validates :email, email_format: true, uniqueness: { case_sensitive: false }, presence: true
end
