class UsersController < ApplicationController

  before_action :authenticate_user,{only: [:show,:edit,:update]}
  #before_action :authenticate_user,{only: [:index,:show,:edit,:update]}

  before_action :forbid_login_user, {only: [:new,:create,:login_form,:login]}

  before_action :ensure_correct_user,{only: [:edit,:update]}



  #def index
   # @user=User.find_by(id:@current_user.id)
  #end

  def show
    @user=User.find_by(id: params[:id])
    
    @graph={}
    @firstnames.each do |firstname|
      if session[:month]=="全期間"
        session[:month]=Date.today
        @graph.store(firstname.name, Doit.where(firstname_id:firstname.id).sum(:post_point))
      else
        @graph.store(firstname.name, Doit.where(firstname_id:firstname.id,created_at:session[:month].in_time_zone.all_month).sum(:post_point))
      end
    end

  end

  def new
    @user=User.new
  end

  def create
    @user=User.new(family: params[:family],email: params[:email],password: params[:password])

    if @user.save 
      session[:user_id]=@user.id
      @firstname=Firstname.new(name: "ママ",user_id: @user.id)
      @firstname.save
      @firstname=Firstname.new(name: "パパ",user_id: @user.id)
      @firstname.save
      @post=Post.new(content:"掃除",point:1,family_id: @user.id)
      @post.save
      @post=Post.new(content:"洗濯",point:1,family_id: @user.id)
      @post.save
      @post=Post.new(content:"料理",point:1,family_id: @user.id)
      @post.save
      @post=Post.new(content:"皿洗い",point:1,family_id: @user.id)
      @post.save
      @post=Post.new(content:"ゴミ出し",point:1,family_id: @user.id)
      @post.save

      flash[:notice]="ユーザー登録が完了しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/new")
    end

  end

  def edit
    @user=User.find_by(id: params[:id])
  end

  def update
    @user=User.find_by(id: params[:id])
    @user.family=params[:family]
    @user.email=params[:email]
    if @user.save
      flash[:notice]="ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end

  def login_form
  end

  def login
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      session[:user_id]=@user.id

      flash[:notice] = "ログインしました"
      redirect_to("/posts/index")
    else
      # @error_messageを定義してください
      @error_message="メールアドレスまたはパスワードが間違っています"
      
      # @emailと@passwordを定義してください
      @email=params[:email]
      @password=params[:password]
      
      
      render("users/login_form")
    end
  end

  def logout
    session[:user_id]=nil
    session[:firstname_id]=nil
    flash[:notice]="ログアウトしました"
    redirect_to("/login")
  end

  def ensure_correct_user
    if @current_user.id!=params[:id].to_i
      flash[:notice]="権限がありません"
      redirect_to("/posts/index")
    end
  end


end
