module OpenData
  class RestClient
    include HTTParty
    base_uri "https://api.data.gov/ed/collegescorecard/v1"

    headers "User-Agent" => "MyAgent_1.0/Ruby"
    headers "Content-Type" => "application/json"
    headers "Accept" => "application/json"

    def query_college(query, page = 0)
      response = self.class.get(
        "/schools?school.name=#{query}&page=#{page}&fields=id,school.name,location&api_key=#{Rails.configuration.open_data_api_key}"
      )
      begin
        parsed_response = response.parsed_response
      rescue JSON::ParserError => e
      end
      {
        status: response.code,
        success: response.success? && defined?(parsed_response).present?,
        data: parsed_response
      }
    end
  end

  extend self 

  def build_colleges_from(response)
    colleges = []
    response[:data]["results"].each do |college|
      colleges << College.new(
        id: college["id"], name: college["school.name"], 
        lat: college["location.lat"], lon: college["location.lon"]
      )
    end
    colleges
  end
end
