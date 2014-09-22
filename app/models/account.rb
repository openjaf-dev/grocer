class Account < ActiveRecord::Base
    
  belongs_to :owner, :class_name => "User"
  accepts_nested_attributes_for :owner

  has_many :users
  accepts_nested_attributes_for :users
  
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
  
  class << self
    def current
      Thread.current[:current_account]
    end
  
    def current=(account)
      Thread.current[:current_account] = account
    end
  end
  
end
