class KittensController < ApplicationController
	def index
		@kittens = Kitten.all
		respond_to do |format|
			format.html
			format.xml { render xml: @kittens}
			format.json { render json: @kittens}
		end
	end

	def show
        @kitten = Kitten.find(params[:id])
        respond_to do |format|
			format.html
			format.xml { render xml: @kitten}
			format.json { render json: @kitten}
		end
	end

	def new
		@kitten = Kitten.new
		@age = (1..50).to_a 
		@cute_and_soft = (1..20).to_a 
	end

	def create
		@kitten = Kitten.new(kitten_params)
		if @kitten.save
			flash[:sucess] = "kitten created!"
			redirect_to @kitten
		else
			flash.now[:danger] = "kitten couldn't be created, how difficult is to create a kitten?"
			render "new"
		end
	end

	def edit
		@kitten = Kitten.find(params[:id])
		@age = (1..50).to_a 
		@cute_and_soft = (1..20).to_a
	end 

	def update
		@kitten = Kitten.find(params[:id])
		if @kitten.update_attributes(kitten_params)
			flash[:sucess] = "kitten updated"
			redirect_to @kitten
		else
			flash.now[:danger] = "kitten couldn't be updated, do you did something wrong?"
			render "edit"
		end
	end

	def destroy
		@kitten = Kitten.find(params[:id])
		@kitten.destroy
		flash[:sucess] = "kitten deleted, douchebag!! "
	    redirect_to kittens_url
    end

    private

    def kitten_params
    	params.require(:kitten).permit(:name, :age, :cuteness, :softness)
    end
end
