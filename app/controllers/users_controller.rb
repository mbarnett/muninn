# More or less standard AuthLogic User controller

class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save      
      redirect_to new_user_authorizations_path(@user)
    else
      render :action => :new
    end
  end
  
  def edit
    @authorized = authorized?
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to edit_account_path
    else
      render :action => :edit
    end
  end
  
end
