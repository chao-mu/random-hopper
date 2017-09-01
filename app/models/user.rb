class User < ApplicationRecord
  belongs_to :pinned_task, class_name: "Task", optional: true
  has_many :hoppers

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
