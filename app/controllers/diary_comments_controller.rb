class DiaryCommentsController < ApplicationController
	def create
	
	@diary= Diary.find(params[:diary_id])
	comment = current_user.diary_comments.new(diary_comment_params)
	comment.diary_id = @diary.id

	if comment.save
	     else
	     	@new_book = diary.new
	     	render "/diaries/show"
	     end    		
	end

	def destroy
		@diary_comment= DiaryComment.find(params[:id])		
		@diary = @diary_comment.diary
		@diary_comment.destroy
	end

	private
	def diary_comment_params
	    params.require(:diary_comment).permit(:comment)
	end
end
