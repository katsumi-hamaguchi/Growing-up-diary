class FavoritesController < ApplicationController
	def create
        @user = current_user
        @diaries = @user.diaries
		@diary = Diary.find(params[:diary_id])
        @favorite = current_user.favorites.new(diary_id: @diary.id)
        @favorite.save
        
    end

	def destroy
        @user = current_user
        @diaries = @user.diaries
		@diary = Diary.find(params[:diary_id])
        @favorite = current_user.favorites.find_by(diary_id: @diary.id)
        @favorite.destroy
        
	end
end
