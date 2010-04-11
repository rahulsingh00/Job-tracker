class UsersController < ApplicationController
  layout 'job_tracker'
  
  before_filter :require_no_user, :only => [:new, :create, :activate, :forgot_password, :process_forgot_password, :retrieve_password, :reset_password]
  before_filter :require_user, :only => [:show, :edit, :update]
  before_filter :load_user_using_perishable_token, :only => [:activate, :retrieve_password]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if verify_recaptcha(:model => @user, :message => "Captcha was wrong") && @user.save
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
    if verify_recaptcha && user
      UserMailer.deliver_activation_mail(user,"forgot_password")
      redirect_to login_url
    else
      flash[:notice] = "You either entered a wrong email or a wrong captcha. Please try again!"
      render :action => 'forgot_password'
    end  
  end
  
  private

  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:token])
    flash[:notice] = "Unable to find your account." unless @user
  end
  
end  
