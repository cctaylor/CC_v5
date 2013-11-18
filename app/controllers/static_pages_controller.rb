class StaticPagesController < ApplicationController
	def home
		@user = User.new
	end

	def printing_services
	end

	def customers
	end

	def about
	end

 	def contact
		if params[:origin] != nil
			@begin = params[:origin]
			@end = "5850 Town and Country Blvd. Ste 702 Frisco, TX 75034"
			@gmap_options = {
				"map_options" => {
					"auto_zoom" => true,
					"auto_adjust" => true,
					"mapTypeControl" => false,
					"detect_location" => false,
					"center_on_user" => false
				},
				"direction" => {
					"data" => {
						"from" => @begin,
						"to" => @end
					},
					"options" => {
						"display_panel" => true,
						"panel_id" => "instructions"
					}
				}
			}
		else
			@end = Gmaps4rails.geocode("5850 Town and Country Blvd. Ste 702 Frisco, TX 75034").to_json
			@gmap_options = {
				"map_options" => {
					"center" => @end,
					"zoom" => 16,
					"auto_zoom" => false,
					"auto_adjust" => true,
					"mapTypeControl" => false,
					"detect_location" => false,
					"center_on_user" => false
				},
				"markers" => { "data" => @end }
			}
		end
	end
end
