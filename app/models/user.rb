class User < ApplicationRecord
  belongs_to :pinned_thing, class_name: "Thing", optional: true
  has_many :hoppers

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
