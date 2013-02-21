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

  validates :email, presence: true, uniqueness: { case_sensitive: false }, email_format: true

end
