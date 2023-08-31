class PostHobbiesController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @post_hobby = PostHobby.new
    @isDraft = @post_hobby.draft?
  end

  def create
    if params[:commit] == "下書き保存"
      @post_hobby = PostHobby.create(post_hobby_params.merge(user_id: current_user.id))
      if @post_hobby.save_draft
        redirect_to drafts_post_hobbies_path
      else
        render :new
      end
    else
      @post_hobby = PostHobby.create(post_hobby_params.merge(user_id: current_user.id))
      tag_list = params[:post_hobby][:tag_name].split(',')
      if @post_hobby.save
        @post_hobby.save_tags(tag_list)
        redirect_to post_hobby_path(@post_hobby)
      else
        render :new
      end
    end
  end

  def index
    @published_post_hobbies = PostHobby.where(user_id: current_user.id).where(post_status: :published).order(created_at: :desc)
    @tag_list = Tag.all
  end

  def show
    @post_hobby = PostHobby.find(params[:id])
  end

  def edit
    @post_hobby = PostHobby.find(params[:id])
    @isDraft = @post_hobby.draft?
  end

  def update
    @post_hobby = PostHobby.find(params[:id])
    if @post_hobby.update(post_hobby_params)
      if params[:commit] == "下書き保存"
        @post_hobby.update(post_status: :draft)
        redirect_to post_hobbies_path, notice: "下書きを保存しました。"
      else
        @post_hobby.update(post_status: :published)
        redirect_to @post_hobby, notice: "投稿を更新しました。"
     end
    else
      render :edit
    end
  end

  def drafts
    @draft_post_hobbies = PostHobby.where(user_id: current_user.id).where(post_status: :draft).order(created_at: :desc)
  end

  private

  def post_hobby_params
    params.require(:post_hobby).permit(:title, :text, :image, :post_status)
  end

  def ensure_correct_user
    @post_hobby = PostHobby.find(params[:id])
    unless @post_hobby.user == current_user
      redirect_to post_hobbiess_path
    end
  end

end
