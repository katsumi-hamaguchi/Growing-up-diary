class DiaryCommentsController < ApplicationController
	def create
	diary = Diary.find(params[:diary_id])
	comment = current_user.diary_comments.new(diary_comment_params)
	comment.diary_id = diary.id
	comment.save
    redirect_to root_path		
	end

	def destroy
	end

	private
	def diary_comment_params
	    params.require(:diary_comment).permit(:comment)
	end
end
