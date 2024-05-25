class CollegesController < ApplicationController
  def index
    @colleges = []
    
    set_query_data if params[:query].present?
      
    render :index
  end

  private 

  def set_query_data
    client = OpenData::RestClient.new
    response = client.query_college(params[:query], page_number)

    if response[:success]
      @colleges = OpenData.build_colleges_from(response) 
      @metadata = response[:data]["metadata"]
      @metadata["total"] / @metadata["per_page"] > page_number ? @next_page = page_number + 1 : @next_page = nil
    end
    @noresults = true if @colleges.empty?
  end

  def page_number
    params[:page].to_i || 0
  end
end