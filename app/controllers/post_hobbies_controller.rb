class PostHobbiesController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @post_hobby = PostHobby.new
    @published = @post_hobby.published?
  end

  def create
    if params[:commit] == "下書き保存"
      @post_hobby = PostHobby.new(post_hobby_params)
      @post_hobby.user_id = current_user.id
      if @post_hobby.save_draft
        redirect_to drafts_post_hobbies_path
      else
        render :new
      end
    else
      @post_hobby = PostHobby.new(post_hobby_params)
      @post_hobby.user_id = current_user.id
      #受け取った値を,で区切って配列する
      tag_list = params[:post_hobby][:name].split(',')
      if @post_hobby.save
        @post_hobby.save_tags(tag_list)
        redirect_to post_hobbies_path
      else
        render :new
      end
    end
  end

  def index
    @published_post_hobbies = PostHobby.where(user_id: current_user.id).where(status: :published).order(created_at: :desc)
    @tag_list = Tag.all
  end

  def show
    @post_hobby = PostHobby.find(params[:id])
  end

  def edit
    @published = @post_hobby.published?
  end

  def update
    if @post_hobby.update(post_hobby_params)
      if params[:commit] == "下書き保存"
        @post_hobby.update(status: :draft)
        redirect_to drafts_post_hobbies_path
      else
        @post_hobby.update(status: :published)
        redirect_to post_hobbies_path
      end
    else
        render :edit
    end
  end

  def drafts
    @draft_post_hobbies = PostHobby.where(user_id: current_user.id).where(status: :draft).order(created_at: :desc)
  end

  private

  def post_hobby_params
    params.require(:post_hobby).permit(:title, :text, :image, :status)
  end

  def ensure_correct_user
    @post_hobby = PostHobby.find(params[:id])
    unless @post_hobby.user == current_user
      redirect_to post_hobbiess_path
    end
  end

end
