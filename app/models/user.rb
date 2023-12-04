class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :borrowings

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  def librarian?
    self.role == 'librarian'
  end

  def member?
    self.role == 'member'
  end
end
