class ConditionController < ApplicationController
    skip_before_action :verify_authenticity_token

    def permit_params(params)
        return params.permit(:date_time, :temp_c,:temp_f, :weather_code, :icon, :desc,
            :windspeed_mph, :windspeed_kmph, :winddir_degree, :winddir_point, :precip_mm, :precip_in,
            :humidity, :visibility, :visibility_miles, :pressure, :pressure_in, :cloud_cover,
            :feels_like_c, :feels_like_f, :uv)
    end

    # Get all conditions -- GET api/conditions
    def index 
        @conditions = Condition.all
        render json: {message: 'success', data: @conditions}
    end 

    # Get one condition by id -- GET api/condition/:id
    def show
        @condition = Condition.find(params[:id])
        render json: {message: 'success', data: @condition}
    end

    # Create one new condition -- POST api/condition
    def create
        api_params = permit_params(params)
        @conditions = self.create_new_condition(api_params)
        render json: {message: 'success', data: @condition}
    end

    # Update one condition -- PUT api/condition/:id
    def update
        api_params = permit_params(params)

        @condition = Condition.update(params[:id], api_params)
        render json: {message: 'success', data: @condition}
    end

    # Destroy one condition by ID -- DELETE api/condition/:id
    def destroy
        begin
            @condition = Condition.find(params[:id])
            @condition.destroy
            render json: {message: 'success'}
        rescue => err
            render json: {message: "ERROR: could not destroy condition id: #{params[:id]}"}
        end
    end
end
