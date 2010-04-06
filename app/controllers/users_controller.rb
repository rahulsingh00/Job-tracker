class UsersController < ApplicationController

  before_filter :require_no_user, :only => [:new, :create, :activate, :forgot_password, :process_forgot_password, :retrieve_password, :reset_password]
  before_filter :require_user, :only => [:show, :edit, :update]
  before_filter :load_user_using_perishable_token, :only => [:activate, :retrieve_password]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account registered.Please follow the link in the activation mail to activate your account!"
      redirect_back_or_default account_url
    else
      render :action => :new
    end
  end
  
  def show
    @user = @current_user
  end
 
  def edit
    @user = @current_user
  end
  
  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end

  def activate
    if !@user.active
      @user.activate!
      flash[:notice] = "Your account has been activated. You can login now!"
      redirect_to login_url
    else
      flash[:notice] = "You are already an active user. Please login using your credentials."
      redirect_to login_url  
    end
  end
  
  def retrieve_password
    render
  end
  
  def reset_password
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to account_url
    else
      render :action => :retrieve_password
    end  
  end
  
  def forgot_password
    @user = User.new()
  end
  
  def process_forgot_password
    user = User.find_by_email(params[:user][:email])
    user.reset_perishable_token!
    activation_url = "http://localhost:3000/retrieve_password/#{user.perishable_token}"
    UserMailer.deliver_activation_mail(user,activation_url,"forgot password")
    redirect_to login_url
  end

  private

  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:token])
    flash[:notice] = "Unable to find your account." unless @user
  end
  
end  
