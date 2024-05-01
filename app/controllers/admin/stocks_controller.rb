module Admin
  class StocksController < ApplicationController
    before_action :set_stock, only: %i[edit update show destroy]
    before_action -> { authorize @stock || Stock }

    add_controller_helpers :stocks, only: :index
    decorates_assigned :stock, :stocks

    def index
      @stocks = policy_scope(Stock).order(:position)
    end

    def show
    end

    def new
      @stock = Stock.new
    end

    def edit
    end

    def create
      @stock = Stock.new(permitted_attributes(Stock))

      if @stock.save
        redirect_to [:admin, @stock], notice: create_successful_notice
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @stock.update(permitted_attributes(stock))
        redirect_to [:admin, @stock], notice: update_successful_notice
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @stock.destroy
      redirect_to admin_stocks_path, notice: destroy_successful_notice
    end

    # :nocov:
    def update_prices
      skip_policy_scope
      RapidApiServices::UpdateStockPrices.new.run!
      redirect_to admin_stocks_path, notice: update_successful_notice
    end
    # :nocov:

    private

    def set_stock
      @stock = policy_scope(Stock).find(params[:id])
    end
  end
end
