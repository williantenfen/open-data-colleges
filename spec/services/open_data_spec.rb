require "rails_helper"

module OpenData 
 describe RestClient do
    describe "#query_college" do
      context "when the API request is successful" do
        let(:client) { OpenData::RestClient.new }
        
        before do
          WebMock.stub_request(
            :get, 
            "https://api.data.gov/ed/collegescorecard/v1/schools?school.name=Ohio&page=0&fields=id,school.name,location&api_key=dummy-key"
          ).to_return(
            body: File.read("spec/fixtures/ohio.json"),
            headers: { "Content-Type" => "application/json" },
            status: 200
          )
        end
        it "returns a successful response" do  
          response = client.query_college("Ohio")
          expect(response[:status]).to eq(200)
          expect(response[:success]).to eq(true)
        end
        it "returns the college data" do
          response = client.query_college("Ohio")
          expect(response[:data]["results"].size).to eq(2)
          expect(response[:data]["results"].first["school.name"]).to eq("Choffin Career  and Technical Center")
        end
      end
    end
  end
end