class QuotesController < ApplicationController
	before_filter :signed_in_user, only: [:new, :create]
	before_filter :signed_in_customer, only: [:update, :show, :edit]
	before_filter :admin_user, only: [:destroy, :index]

	def new
		@quote = current_user.quotes.build
	end

	def create
		@quote = current_user.quotes.build(params[:quote])
		if @quote.save
			flash[:success] = "Your quote has been submitted!"
			sign_out if is_lead?
			redirect_to root_url
		else
			render 'new'
		end
	end

	def destroy
	end

	def update
	end

	def show
		@user = current_user
		@quote = Quote.find(params[:id])
	end

	def edit
	end

	def index
		@user = current_user
		@quotes = Quote.paginate(page: params[:page])		
	end

end
