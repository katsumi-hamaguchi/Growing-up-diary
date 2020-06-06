class TasksController < ApplicationController

    def create 
        @task = Task.new(task_params)
        @task.user_id = current_user.id
        @task.save
	    redirect_to root_path
    end

	def index
		@task = Task.new
	    @user_current = current_user
	    @tasks = @user_current.tasks		
	end

	def destroy
		@task = Task.find(params[:id])
	    @task.destroy
	    redirect_to root_path
	end

	private #ストロングパラメータ
    def task_params
      params.require(:task).permit(:body)
    end
end
