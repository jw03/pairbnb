class UsersController < ApplicationController
  
  def new
  end

  def show
  	@user = User.find(params[:id])
  end
  
  def update
  	@user = User.find(params[:id])
  
  	unless params[:user].nil? #means i inserted image/updated sth
	  	@user.update(user_params) 

	  	if @user.save
	      redirect_to @user
	    else
	      render :show
	    end
	  else
	  	render :show 
	  end
  end

  def delete_image
  	
  	@user = User.find(params[:id])
    @user.remove_avatars!
    @user.save
  	redirect_to @user
  end

  private

  def user_params
    params.require(:user).permit(:email, {avatars:[]})
  end
end
