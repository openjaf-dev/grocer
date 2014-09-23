class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  extend DeviseOverrides
    
  #include AccountScoped
  
  belongs_to :account
  
  #after_create :ensure_account
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  accepts_nested_attributes_for :account

end
