class ApplicationController < ActionController::Base
    before_action :set_current_user
  
    def set_current_user
      @current_user=User.find_by(id: session[:user_id])
      @current_name=Firstname.find_by(id:session[:firstname_id])
      @firstnames=Firstname.where(user_id:session[:user_id])
      if session[:month]==nil
        session[:month]=Date.today
      end

    end

    def authenticate_user
        if @current_user==nil
          flash[:notice]="ログインが必要です"
          redirect_to("/login")
        end
    end

    def forbid_login_user
      if @current_user
        flash[:notice]="すでにログインしています"
        redirect_to("/posts/index")
      end
    end

    def month
      session[:month]=session[:month].to_date >> params[:count].to_i
      if params[:count]=="今月"
        session[:month]=Date.today
      elsif params[:count]=="全期間"
        session[:month]=Date.today
      end
      
      redirect_to request.referer
    end
  
  

end
