class UsersController < ApplicationController
 
	def event
	    @user = User.find(params[:id])  	
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
	    @user = User.find(params[:id])	
	end

	def update
	    @user = User.find(params[:id])
	    if @user.update(user_params)
	       flash[:notice] = "登録者の更新が完了しました"  
           redirect_to user_path(current_user.id)
        else
           flash[:notice] = "もう一度ご確認の上、ご入力お願いします。" 
           render "edit"
        end	
	end

	def change_pass
	    @user = User.find(params[:id]) 	
	end

	def update_pass
	    @user = User.find(params[:id])
	    if  @user.update(user_params)
			flash[:notice] = "パスワード変更完了しました。再度ログインしてください"
            redirect_to root_path
        else
        	flash[:notice] = "もう一度ご確認の上、ご入力お願いします。"
            render "password"
        end 	
	end

	def withdrawal
	    @user = User.find(params[:id])		
	end

	def update_user
	    @user = User.find(params[:id])
        @user.update(is_deleted: false)
        reset_session
        flash[:notice] = "ありがとうございました。またのご利用お待ちしております。"
        redirect_to root_path		
	end

	private #ストロングパラメータ
	  def user_params
	      params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :nickname, :email, :postcode, :password, :password_confirmation, :prefecture_code, :address_city, :address)
	  end
end
