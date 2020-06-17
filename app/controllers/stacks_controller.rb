class StacksController < ApplicationController
	def create
		goal = Goal.find(params[:goal_id])
		stack = current_user.stacks.new(stack_params)
		stack.user_id = current_user.id
		stack.goal_id = goal.id
		stack.save
	    redirect_to root_path		
	end

	def index
		@stack = Stack.all
		@user = current_user
		@goal = Goal.find(params[:goal_id])
	end

	def show
		@stack = Stack.find(params[:id])
	end

	def edit
		@goal = Goal.find(params[:goal_id])
		#@stack = Stack.find(params[:id])
		@stack = Stack.find_by(id: params[:id], goal_id: params[:goal_id])
	end

	def update
		@stack = Stack.find(params[:id])
	    if @stack.update(stack_params)
	       flash[:notice] = "目標設定の編集が完了しました"  
           redirect_to root_path
        else
           flash[:notice] = "もう一度ご確認の上、ご入力お願いします。" 
           render "edit"
        end				
	end

	def destroy
		stack = Stack.find(params[:id])
		#stack = Stack.find_by(id: params[:id], goal_id: params[:goal_id])
		stack.destroy
        redirect_to root_path
	end

	private
	def stack_params
	    params.require(:stack).permit(:study_time)
	end
end
