class OrderTotal < ActiveRecord::Base
  include AccountScoped
  include Dashboard::ByTime
  
  belongs_to :order
  def self.fun_revenues() "(&:total)" end
end
