require 'rails_helper'
require './spec/support/auth_helpers'
require 'json'

RSpec.configure do |c|
    c.include AuthHelpers
end

RSpec.describe 'Scenario API' do
    before(:all) do
        @jwt = auth()
        @scenario = Scenario.create(name: "eetac")
        @rrh = @scenario.rrhs.create(ip: "192.168.1.2", version: '1.2', model: 'usrp', latitude: -10.4, longitude: -50)
    end
    after :all do
       @scenario.destroy
       @rrh.destroy
    end 
    let(:json) {JSON.parse(response.body)}
    let(:request_header) do 
        {'CONTENT_TYPE' => 'application/json', 
         'ACCEPT' => 'application/json',
         "Authorization" => "Authorization: #{@jwt}" }
    end

     context "GET #index" do
         it 'return all scenarios' do
             get '/api/v1/scenarios',
             headers: { "Authorization" => "Authorization: #{@jwt}" }
             expect(json[0]['id']).to eql(@scenario.id)
         end
     end

     context "GET #show" do
         it 'show request' do
             get "/api/v1/scenarios/#{@scenario.id}",
             headers: { "Authorization" => "Authorization: #{@jwt}" }
             expect(json['name']).to eql(@scenario.name)
         end
     end

     context 'GET #destroy' do
         it 'destroy scenario' do
             delete "/api/v1/scenarios/#{@scenario.id}",
             headers: { "Authorization" => "Authorization: #{@jwt}" }
             expect(json['message']).to eql('Scenario deleted')
         end
     end

    context 'POST #create' do
        it 'create scenario' do
            params = { name: 'eetac'}
            post '/api/v1/scenarios', params: params.to_json, headers: request_header
            expect(json['name']).to eql(params[:name])
        end
    end

     context "PATCH #upgrade" do
         it "Edit scenario" do
             params = {name: 'scenario'}
             patch "/api/v1/scenarios/#{@scenario.id}", params: params.to_json, headers: request_header
             expect(json['name']).to eql(params[:name])
         end
    end

end
