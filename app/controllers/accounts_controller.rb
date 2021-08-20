class AccountsController < ApplicationController
  before_action :set_account, only: %i[ show edit update destroy new_withdraw withdraw new_deposit deposit ]

  # GET /accounts or /accounts.json
  def index
    @accounts = Account.all
  end

  # GET /accounts/1 or /accounts/1.json
  def show
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts or /accounts.json
  def create
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: "Account was successfully created." }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1 or /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: "Account was successfully updated." }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1 or /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: "Account was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def new_withdraw
  end

  def withdraw
    @errors = []
    if (@account.balance - @amount.to_d < 0.00) && (@account.present?)
      return @errors << "Not enough funds"
    end
    @account.update!(balance: @account.balance - @amount.to_d)
    redirect_to withdraw_user_account_path(@account)
  end

  def new_deposit
    
  end

  def deposit
    @account.update!(balance: @account.balance + @amount.to_d)
    redirect_to deposit_user_account_path(@account)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
      @amount = params[:amount]
    end

    # Only allow a list of trusted parameters through.
    def account_params
      params.require(:account).permit(:account_number, :balance, :user_id)
    end
end
