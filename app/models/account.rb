class Account < ActiveRecord::Base
  
  has_one :users, :through => :members
    
  belongs_to :owner, :class_name => "User"
  accepts_nested_attributes_for :owner

  has_many :users
  
  has_one :organization
  accepts_nested_attributes_for :organization

  def self.create_with_owner(params={})
    account = new(params)
    if account.save
      account.users << account.owner
    end
    account
  end

  def owner?(user)
    owner == user
  end
  
  def self.current
    Thread.current[:current_account]
  end
  
  def self.current=(account)
    Thread.current[:current_account] = account
  end
  
end
