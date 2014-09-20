class Account < ActiveRecord::Base
  
  has_one :users, :through => :members
    
  belongs_to :owner, :class_name => "User"
  accepts_nested_attributes_for :owner

  has_many :members, :class_name => "Member"
  has_many :users, :through => :members
  
  belongs_to :organization
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
end
