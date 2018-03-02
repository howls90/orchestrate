require 'rails_helper'

RSpec.describe 'Scenario API' do
    before(:all) do
        Scenario.delete_all
        Rrh.delete_all
        @scenario = Scenario.create(name: "eetac")
        @rrh = Rrh.create(ip: "192.168.1.2", version: '1.2', model: 'usrp', latitude: -10.4, longitude: -50, scenario_id: @scenario.id)
    end 
    let(:json) {JSON.parse(response.body)}
    let(:request_header) do 
        {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
    end

    context "GET #index" do
        it 'return all scenarios' do
            get '/api/v1/scenarios'
            expect(json[0]['name']).to eql('eetac')
        end
    end

    context "GET #show" do
        it 'show request' do
            get "/api/v1/scenarios/#{@scenario.id}"
            expect(json['name']).to eql('eetac')
        end
    end

    context 'GET #destroy' do
        it 'destroy scenario' do
            delete "/api/v1/scenarios/#{@scenario.id}"
            expect(json['message']).to eql('Scenario deleted')
        end
    end

    context 'POST #create' do
        it 'create scenario' do
            params = { name: 'eetac' }
            post '/api/v1/scenarios', params: params.to_json, headers: request_header
            expect(json['name']).to eql('eetac')
        end
    end

    context "PATCH #upgrade" do
        it "Edit scenario" do
            params = {name: 'scenario'}
            patch "/api/v1/scenarios/#{@scenario.id}", params: params.to_json, headers: request_header
            expect(json['name']).to eql('scenario')
        end
    end

end
