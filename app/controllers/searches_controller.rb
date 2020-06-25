class SearchesController < ApplicationController
	def search
		@user = current_user
	    @diary = params[:option]		
		@how_search = params[:choice] 
		if @diary == "1"
		   @diaries = Diary.search(params[:search], @diary, @how_search)
		else
		   @diaries = Diary.search(params[:search], @diary, @how_search)
		end
        render "search"
	end

	def search_all
		@diary_or_user = params[:option]		
		@how_search = params[:choice]
		if @diary_or_user == "1"
		   @diaries = Diary.search(params[:search], @diary_or_user, @how_search)
		else
		   @user = User.search(params[:search], @diary_or_user, @how_search)
		end
        render "search_all"		
	end
end
