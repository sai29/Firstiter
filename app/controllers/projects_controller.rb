class ProjectsController < ApplicationController
	before_action :signed_in_user, only: [:index, :create, :destroy]

	def index
		@projects = Project.all
	end
	def create
		@project = current_user.projects.build(project_params)
		if @project.save
			flash[:success] = "Project Created"
			redirect_to root_url
		else
			render 'static_pages/home'
		end
	end

	def destroy
	end

	private

		def project_params
			params.require(:project).permit(:name, :tagline, :description)
		end
end