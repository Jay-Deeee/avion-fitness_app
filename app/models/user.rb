class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:confirmable

  has_many :workouts
  has_many :calculators, dependent: :destroy
  has_many :macros, dependent: :destroy

  def target_macro
    macros.find_by(target: true)
  end

  def today_macros
    macros.logged.today
  end
end
