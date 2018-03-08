require 'rails_helper'
require './spec/support/auth_helpers'

RSpec.configure do |c|
    c.include AuthHelpers
end

RSpec.describe 'pop API' do
    before(:all) do
        @jwt = auth()
        @pop = Pop.create(name: "eetac", ip: "192.168.1.5", instance: "OpenStack")
    end
    after :all do
       @pop.destroy
       @user.destroy
    end 
    let(:json) {JSON.parse(response.body)}
    let(:request_header) do 
        {'CONTENT_TYPE' => 'application/json', 
         'ACCEPT' => 'application/json',
         "Authorization" => "Authorization: #{@jwt}" }
    end

    context "GET #index" do
        it 'return all pops' do
            get '/api/v1/pops',
            headers: { "Authorization" => "Authorization: #{@jwt}" }
            expect(json[0]['id']).to eql(@pop.id)
        end
    end

    context "GET #show" do
        it 'show request' do
            get "/api/v1/pops/#{@pop.id}",
            headers: { "Authorization" => "Authorization: #{@jwt}" }
            expect(json['name']).to eql(@pop.name)
        end
    end

    context 'GET #destroy' do
        it 'destroy pop' do
            delete "/api/v1/pops/#{@pop.id}",
            headers: { "Authorization" => "Authorization: #{@jwt}" }
            expect(json['message']).to eql('Pop deleted')
        end
    end

    context 'POST #create' do
        it 'create pop' do
            params = { name: "eetac", ip: "192.168.1.5", instance: "OpenStack" }
            post '/api/v1/pops', params: params.to_json, headers: request_header
            expect(json['name']).to eql('eetac')
        end
    end

    context "PATCH #upgrade" do
        it "Edit pop" do
            params = {name: "eetac2", ip: "192.168.1.5", instance: "OpenStack"}
            patch "/api/v1/pops/#{@pop.id}", params: params.to_json, headers: request_header
            expect(json['name']).to eql('eetac2')
        end
    end

end
