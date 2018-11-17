class StatesController < ApplicationController
  def load_cities
    begin
      cities = State.find(params[:state_id]).cities
    rescue
      cities = nil
    end
    render json: {cities: cities}
  end
end
