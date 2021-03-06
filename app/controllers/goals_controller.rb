class GoalsController < ApplicationController

    def new 
        @goal_new = Goal.new
        @user = current_user
	    @tasks = @user.tasks
	    @task = Task.new 	
    end

	def create
		@user = current_user
	    @goal_new = Goal.new(goal_params)
	    @goal_new.user_id = current_user.id
	    @goal_new.save
	    redirect_to goals_path(@user)		
	end

	def index
	    @user = current_user
	    @goals = @user.goals
	    @tasks = @user.tasks
	    @task = Task.new		
	end

	def show
		@goal = Goal.find(params[:id])
	    @stack_new = Stack.new
	    @data = @goal.stacks
	    @data1 = Stack.all
	    @data2 = Goal.all
	    @user = current_user
	    @user_data = @user.goals
	    @goals = {}
	    @stydy_times = {}
	    @set_times = {}
	    tmp_total_study_time = 0
	    tmp_total_set_time = 0
	    @data.group_by_day(:created_at).sum(:study_time).each do |key, value|
	    	@goals[key] = @goal.set_time
	    	tmp_total_study_time += value
	    	@stydy_times[key] = tmp_total_study_time
	    	tmp_total_set_time += @goal.set_time
	    	@set_times[key] =  tmp_total_set_time 
	    end
	end

	def edit
	    @goal = Goal.find(params[:id])		
	end

	def update
	    @goal = Goal.find(params[:id])
	    if @goal.update(goal_params)
	       flash[:notice] = "目標設定の編集が完了しました"  
           redirect_to goal_path(@goal)
        else
           flash[:notice] = "もう一度ご確認の上、ご入力お願いします。" 
           render "edit"
        end				
	end

	def destroy
		@user = current_user
		@goal = Goal.find(params[:id])
	    @goal.destroy
	    redirect_to goals_path(@user)
	end

	private #ストロングパラメータ
    def goal_params
      params.require(:goal).permit(:title, :body, :set_time)
    end
end
