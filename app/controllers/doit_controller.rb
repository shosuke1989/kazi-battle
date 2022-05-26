class DoitController < ApplicationController
    before_action :authenticate_user
  
  
    def show
    end
  
  
    def create
      if session[:firstname_id]==nil
        flash[:notice]="ユーザーを選択してください"
      else
        point=Post.find_by(id:params[:id]).point
        @doit = Doit.new(firstname_id: @current_name.id, post_id: params[:id],user_id:@current_user.id,post_point:point,created_at: params[:day])
        @doit.save
      end
      flash[:day]="#{params[:day]}"
      redirect_to "/posts/index"
    end
  
    def destroy
      @doit = Doit.find_by(id:params[:id])
      @doit.destroy
      flash[:day]="#{params[:day]}"

      redirect_to("/posts/index")
    end
  
  end
  