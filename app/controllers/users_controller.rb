class UsersController < ApplicationController
	before_filter :signed_in_user,		only: [:update]
	before_filter :signed_in_lead,		only: [:lead_to_customer]
	before_filter :signed_in_customer,	only: [:show, :edit, :change_password]
	before_filter :admin_user,			only: [:index, :destroy]

	def show
		@user = User.find(params[:id])
		if current_user.admin?
			@quotes = Quote.paginate(page: params[:page])
		else
			@quotes = @user.quotes.paginate(page: params[:page])
		end
	end

	def new
		@user = User.new
	end

	def create
		if @user = User.find_by_email(params[:user][:email])
			if @user.lead
				sign_in @user
				flash[:alert] = "Please complete your profile before entering the details of your quote request."
				redirect_to lead_to_customer_path
			else
				flash[:alert] = "Please sign in."
				redirect_to signin_path
			end
		else
			@user = User.new(params[:user])
			if setting_password?
				@user.toggle!(:lead) unless @user.lead == false
			end
			if @user.save
				sign_in @user
				UserMailer.registration_confirmation(@user).deliver
				redirect_to rfq_path
			else
				render 'new'
			end
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def change_password
		@user = User.find(params[:id])
	end

	def lead_to_customer
		@user = current_user
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			if @user.lead
				@user.toggle!(:lead)
				sign_in @user
				flash[:success] = "Profile updated"
				redirect_to rfq_path
			else
				sign_in @user
				flash[:success] = "Profile updated"
				redirect_to @user
			end
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

	def admin_toggle
		@user = User.find(params[:id])
		@user.toggle!(:admin)
	end

	private

		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_url) unless current_user?(@user)
		end

		def setting_password?
			(@user.password != nil) || (@user.password_confirmation != nil)
		end

		def password_exists?
			@user.password_digest != nil
		end

end