class GoalsController < ApplicationController

    def new 
        @goal_new = Goal.new
        @user = current_user
	    @tasks = @user.tasks
	    @task = Task.new 	
    end

	def create
	    @goal_new = Goal.new(goal_params)
	    @goal_new.user_id = current_user.id
	    @goal_new.save
	    redirect_to root_path		
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
	    #@goal_data= @goal.stacks.group("date(created_at)").count
	    @data = @goal.stacks
	    @data1 = Stack.all
	    @data2 = Goal.all
	    @user = current_user
	    @user_data = @user.goals
	    # {Sun, 14 Jun 2020=>4.2, Mon, 15 Jun 2020=>0, Tue, 16 Jun 2020=>2.4, Wed, 17 Jun 2020=>1.2}
	    #@data.group_by_day(:created_at).sum(:study_time).map {|key, value| [key, @goal.set_time] }.to_h
	    # {Sun, 14 Jun 2020=>4.2, Mon, 15 Jun 2020=>4.2, Tue, 16 Jun 2020=>6.6, Wed, 17 Jun 2020=>7.8}
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
           redirect_to root_path
        else
           flash[:notice] = "もう一度ご確認の上、ご入力お願いします。" 
           render "edit"
        end				
	end

	def destroy
		@goal = Goal.find(params[:id])
	    @goal.destroy
	    redirect_to root_path
	end

	private #ストロングパラメータ
    def goal_params
      params.require(:goal).permit(:title, :body, :set_time)
    end
end
