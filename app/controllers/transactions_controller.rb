class TransactionsController < ApplicationController
  before_action :set_account

  def transfer_page
    
  end

  def transfer
    @errors = []
    if (@sender_account.present?) && (@sender_account.balance - @amount.to_d < 0.00)
      return @errors << "Not enough funds"
    end

    if !@receiver_account.present?
      return @errors << "invalid receiver account number"
    end

    if @errors.count == 0
      ActiveRecord::Base.transaction do
        #deduct from sender
        @account.update!(balance: @account.balance - @amount.to_d)

        #add to receiver
        @receiver_account.update!(balance: @receiver_account.balance + @amount.to_d)
      end
    end
    redirect_to transfer_page_user_account_path(@account)
  end

  private
    def set_account
      @account = Account.find(params[:id])
      @sender_account = Account.find(params[:id])
      @receiver_account = Account.find_by(account_number: params[:receiver_account_number])
      @amount = params[:amount]
    end
end
