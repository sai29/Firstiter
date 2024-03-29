class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index,:edit, :update]
  before_action :correct_user, only: [:edit, :update]
   def index
    @users = User.paginate(page: params[:page])
  end
  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
    @projects = @user.projects.paginate(page: params[:page])
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      sign_in @user
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile Updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end
    
  
  private

  def user_params
  	params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
