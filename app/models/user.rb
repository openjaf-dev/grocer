class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  extend DeviseOverrides
    
  include AccountScoped
  
  #before_save :ensure_account
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  accepts_nested_attributes_for :account
  
  private
  
    def ensure_account
      self.account ||= Account.new
    end   

end
