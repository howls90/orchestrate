require 'rails_helper'

RSpec.describe 'alarms API' do
    before(:all) do
        Alarm.new(name: "eetac").save
    end 
    let(:json) {JSON.parse(response.body)}
    let(:request_header) do 
        {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
    end

    context "GET #index" do
        it 'return all alarms' do
            get '/api/v1/alarms'
            expect(json[0]['name']).to eql('eetac')
        end
    end

    context "GET #show" do
        it 'show request' do
            get '/api/v1/alarms/1'
            expect(json['name']).to eql('eetac')
        end
    end

    context 'GET #destroy' do
        it 'destroy alarms' do
            delete '/api/v1/alarms/1'
            expect(json['message']).to eql('Alarm deleted')
        end
    end

    context 'POST #create' do
        it 'create alarms' do
            params = { name: 'eetac' }
            post '/api/v1/alarms', params: params.to_json, headers: request_header
            expect(json['name']).to eql('eetac')
        end
    end

    context "PATCH #updade" do
        it "Update alarms" do
            params = {name: 'alarms'}
            patch '/api/v1/alarms/1', params: params.to_json, headers: request_header
            expect(json['name']).to eql('alarms')
        end
    end

end
