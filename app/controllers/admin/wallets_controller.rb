module Admin
  class WalletsController < ApplicationController
    before_action :set_wallet, only: %i[edit update show destroy]
    before_action -> { authorize @wallet || Wallet }

    add_controller_helpers :wallets, only: :index
    decorates_assigned :wallet, :wallets

    def index
      @wallets = policy_scope(Wallet)
    end

    def show
    end

    def new
      @wallet = Wallet.new
    end

    def edit
    end

    def create
      @wallet = Wallet.new(permitted_attributes(Wallet))

      if @wallet.save
        redirect_to [:admin, @wallet], notice: create_successful_notice
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @wallet.update(permitted_attributes(wallet))
        redirect_to [:admin, @wallet], notice: update_successful_notice
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @wallet.destroy
      redirect_to admin_wallets_path, notice: destroy_successful_notice
    end

    private

    def set_wallet
      @wallet = policy_scope(Wallet).find(params[:id])
    end
  end
end
