module Admin
  class PositionsController < ApplicationController
    before_action :set_position, only: %i[edit update show destroy]
    before_action -> { authorize @position || Position }

    add_controller_helpers :positions, only: :index
    decorates_assigned :position, :positions

    def index
      @positions = policy_scope(Position)
    end

    def show
    end

    def new
      @position = Position.new
    end

    def edit
    end

    def create
      @position = Position.new(permitted_attributes(Position))

      if @position.save
        redirect_to [:admin, @position], notice: create_successful_notice
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @position.update(permitted_attributes(position))
        redirect_to [:admin, @position], notice: update_successful_notice
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @position.destroy
      redirect_to admin_positions_path, notice: destroy_successful_notice
    end

    private

    def set_position
      @position = policy_scope(Position).find(params[:id])
    end
  end
end
