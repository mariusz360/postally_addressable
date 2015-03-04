class UsersController < ApplicationController
  before_filter :set_user

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render :show
    else
      render :new
    end
  end

  def edit
  end

  def update
    @user.attributes = user_params
    if @user.save
      render :show
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url
  end

  private

  def set_user
    return unless params[:id]
    @user = User.where(id: params[:id]).first
    not_found unless @user
  end

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :address_line_1,
      :address_line_2,
      :city,
      :state,
      :postal_code,
      :country
    )
  end
end