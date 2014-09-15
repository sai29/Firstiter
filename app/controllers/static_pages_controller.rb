class StaticPagesController < ApplicationController
  def home
  	if signed_in?
	  	@project = current_user.projects.build 
	  end
  end


  def contact
  end

  def about
  end
end
