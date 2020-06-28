class DiariesController < ApplicationController
	def new
	    @diary_new = Diary.new
	    @user = current_user
	    @tasks = @user.tasks
	    @task = Task.new	
	end

	def create		
	    @diary_new = Diary.new(diary_params)
	    @diary_new.user_id = current_user.id
	    @diary_new.save
	    redirect_to diaries_path(current_user.id)	
	end

	def index
		@user = current_user
	    @diaries = @user.diaries
	    @tasks = @user.tasks
	    @task = Task.new		
	end

	def show
	    @diary = Diary.find(params[:id])
	    @diary_comment = DiaryComment.new		
	end

	def edit
	    @diary = Diary.find(params[:id])		
	end

	def update
		@diary = Diary.find(params[:id])
	    if @diary.update(diary_params)
	       flash[:notice] = "日記の編集が完了しました"  
           redirect_to diary_path(@diary)
        else
           flash[:notice] = "もう一度ご確認の上、ご入力お願いします。" 
           render "edit"
        end			
	end

	def destroy
	    @diary = Diary.find(params[:id])
	    @diary.destroy
	    redirect_to diaries_path(current_user.id)		
	end

	def index_all
		@user = User.find(params[:id])
	    @diaries = Diary.all
	    @current_user = current_user
	    @tasks = @current_user.tasks
	    @task = Task.new	
	end


	private 
    def diary_params
      params.require(:diary).permit(:title, :body, :image)
    end


end
