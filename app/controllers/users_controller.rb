class UsersController < ApplicationController
	before_filter :signed_in_user,	only: [:index, :edit, :show, :update, :destroy]
	before_filter :correct_user,	only: [:edit, :update]
	before_filter :admin_user,		only: :destroy

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def create
		if @user = User.find_by_email(params[:user][:email])
			if @user.lead
				sign_in @user
				render 'edit'
			else
				redirect_to signin_path
			end
		else
			@user = User.new(params[:user])
			if setting_password?
				@user.toggle!(:lead) unless @user.lead == false
			end
			if @user.save
				sign_in @user
				redirect_to rfq_path
			else
				render 'new'
			end
		end
	end

	def edit
	end

	def update
		if @user.update_attributes(params[:user])
			if setting_password?
				@user.toggle!(:lead) unless @user.lead == false
				sign_in @user
			end
			flash[:success] = "Profile updated"
			redirect_to rfq_path
		else
			render 'edit'
		end
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User destroyed."
		redirect_to users_url
	end

	def index
		@users = User.paginate(page: params[:page])
	end

	private

		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_url) unless current_user?(@user)
		end

		def admin_user
			redirect_to(root_url) unless current_user.admin?
		end

		def setting_password?
			(@user.password != '' && @user.password != nil) || (@user.password_confirmation != '' && @user.password_confirmation != nil)
		end

		def password_exists?
			@user.password_digest != nil
		end

end