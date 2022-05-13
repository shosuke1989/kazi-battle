class FirstnamesController < ApplicationController

  def create
    @firstname=Firstname.new(name: params[:name],user_id: params[:id])
    if @firstname.save 
      session[:firstname_id]=@firstname.id
      flash[:notice]="ユーザーを作成しました"
      redirect_to("/users/#{params[:id]}")
    else
      redirect_to("/users/#{params[:id]}")
    end

  end

  def about
    @firstname=Firstname.find_by(id: params[:id])
    
    @graph={}
    @doits=Doit.group(:post_id).where(firstname_id: params[:id],created_at:session[:month].in_time_zone.all_month).sum(:post_point)
    keys=@doits.keys
    values=@doits.values
    keys.zip(values).each do |key,value|
      @graph.store(Post.find_by(id: key).content,value)
    end

  end


  def edit
    @firstname=Firstname.find_by(id: params[:id])
  end

  def new
    @firstname=Firstname.new
    @user=User.find_by(id: params[:id])
  end


  def update
    @firstname=Firstname.find_by(id: params[:id])
    @firstname.name=params[:name]
    if @firstname.save
      flash[:notice]="ユーザー名を編集しました"
      redirect_to("/users/#{@current_user.id}")
    else
      render("firstnames/edit")
    end
  end


  def destroy
    @firstname=Firstname.find_by(id: params[:id])
    @firstname.destroy
    flash[:notice]="ユーザーを削除しました"
    redirect_to("/users/#{@current_user.id}")
  end

  def select
    session[:firstname_id]=params[:id]
    redirect_to request.referer
  end
  


end
