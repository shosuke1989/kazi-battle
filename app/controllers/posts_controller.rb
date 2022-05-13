class PostsController < ApplicationController

  before_action :authenticate_user

  before_action :ensure_correct_user,{only: [:edit,:update,:destroy]}


  def index
    @posts = Post.where(family_id:@current_user.id).order(created_at: :desc)
    @firstname=Firstname.all
    @time=Date.today
    if  params[:day]!= nil
      @time=params[:day].to_date+params[:count].to_i
    elsif flash[:day]!=nil
      @time=flash[:day].to_date
    end

  

  end






  def show
    @post=Post.find_by(id:params[:id])
  end

  def new
    @post=Post.new
  end

  def create
    @post=Post.new(content:params[:content],point:params[:point],family_id: @current_user.id)
    if @post.save
      flash[:notice]="家事内容を作成しました"
      redirect_to("/posts/index")
    else
      render("posts/new")
    end
  end

  def edit
    @post=Post.find_by(id: params[:id])
  end

  def update
    @post=Post.find_by(id: params[:id])
    @post.content=params[:content]
    @post.point=params[:point]
    if @post.save
      flash[:notice]="家事内容を編集しました"
      redirect_to("/posts/index")
    else
      @post.point=1
      render("posts/edit")
    end
  end

  def destroy
    @post=Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice]="家事内容を削除しました"
    redirect_to("/posts/index")

  end

  def ensure_correct_user
    @post=Post.find_by(id: params[:id])
    if @post.family_id!=@current_user.id
      flash[:notice]="権限がありません"
      redirect_to("/posts/index")
    end
  end



end
