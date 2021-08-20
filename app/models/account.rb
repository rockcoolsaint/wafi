class Account < ApplicationRecord
  belongs_to :user

  before_save :gen_acc_num

  def gen_acc_num
    return unless self.account_number.blank?
    
    self.account_number = gen_num
  end

  def gen_num
    loop do
      num = SecureRandom.random_number * 10**10
      acc_num = num.to_i
      break acc_num unless Account.find_by(account_number: acc_num)
    end
  end
end
