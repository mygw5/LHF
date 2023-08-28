class UsersController < ApplicationController
  before_action :if_not_admin, only: [:index]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @post_hobbies = @user.post_hobby
  end

  def mypage
    @user = current_user
    @post_hobbies = @user.post_hobby
  end

  def edit
  end

  def update

  end

  def confirm_withdraw
  end

  private

  def user_params
    params.require(:user).permit(:name, :hobby, :image, :is_deleted)
  end

  def if_not_admin
    redirect_to root_path unless current_user.admin?
  end



end
