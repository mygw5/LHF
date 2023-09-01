class UsersController < ApplicationController
  before_action :if_not_admin, only: [:index]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @group = @user.groups
    ##公開中の投稿のみ表示させる
    @post_hobby = @user.post_hobbies.where(post_status: :published)
  end

  def mypage
    @user = current_user
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
