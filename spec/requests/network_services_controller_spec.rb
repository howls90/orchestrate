require 'rails_helper'
require './spec/support/auth_helpers'

RSpec.configure do |c|
  c.include AuthHelpers
end

RSpec.describe 'Network Service API' do
    before(:all) do
        @jwt = auth()
        @network_service = @user.network_services.create(name: "networkservice")
    end 
    after(:all) do
        @network_service.destroy
        @user.destroy
    end
    let(:json) {JSON.parse(response.body)}
    let(:request_header) do 
        {'CONTENT_TYPE' => 'application/json', 
         'ACCEPT' => 'application/json', 
         "Authorization" => "Authorization: #{@jwt}" }
    end

    context "GET #index" do
        it 'return all network services' do
            get "/api/v1/network_services", 
                headers: { "Authorization" => "Authorization: #{@jwt}" }
            expect(json[0]['id']).to eql(@network_service.id)
        end
    end

    context "GET #show" do
        it 'show request' do
            get "/api/v1/network_services/#{@network_service.id}", 
                headers: { "Authorization" => "Authorization: #{@jwt}" }
            expect(json['name']).to eql('networkservice')
        end
    end

     context 'GET #destroy' do
         it 'destroy Network Service' do
             delete "/api/v1/network_services/#{@network_service.id}", 
             headers: { "Authorization" => "Authorization: #{@jwt}" }
             expect(json['message']).to eql('Network Service deleted')
         end
     end

     context 'POST #create' do
         it 'create network service' do
             params = { name: 'networkservice2' }
             post "/api/v1/network_services", 
                  params: params.to_json, headers: request_header
             expect(json['name']).to eql('networkservice2')
         end
     end

     context "PATCH #update" do
         it "Edit Network Service" do
             params = {name: 'networservice2'}
             patch "/api/v1/network_services/#{@network_service.id}", 
                   params: params.to_json, headers: request_header
             expect(json['name']).to eql('networservice2')
         end
     end
end
