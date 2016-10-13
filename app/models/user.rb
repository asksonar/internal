class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :welcome_email

  validates_presence_of :full_name

  private

  def welcome_email
    Mailer.welcome_email(self).deliver_now
  end
end
