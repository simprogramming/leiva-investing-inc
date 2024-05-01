module Admin
  class UsersController < ApplicationController
    before_action :set_user, only: %i[edit update show destroy]
    before_action -> { authorize @user || User }

    add_controller_helpers :users, only: :index
    decorates_assigned :user, :users

    def index
      @users = policy_scope(User).order(:first_name, :last_name)
    end

    def show
    end

    def edit
    end

    def update
      @user.assign_attributes(user_params)
      if @user.save
        redirect_to admin_users_path, notice: update_successful_notice
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @user.destroy
      redirect_to admin_users_path, notice: destroy_successful_notice
    end

    private

    def set_user
      @user = policy_scope(User).find(params[:id])
    end

    def user_params
      return permitted_attributes(User) if params.dig(:user, :password).present?

      permitted_attributes(User).except(:password, :password_confirmation)
    end
  end
end
