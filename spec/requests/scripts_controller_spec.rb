require 'rails_helper'

RSpec.describe 'Scripts API' do
    before(:all) do
        Script.new(name: "script").save
    end 
    let(:json) {JSON.parse(response.body)}
    let(:request_header) do 
        {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
    end

    context "GET #index" do
        it 'return all scripts' do
            get '/api/v1/scripts'
            expect(json[0]['name']).to eql('script')
        end
    end

    context "GET #show" do
        it 'show request' do
            get '/api/v1/scripts/1'
            expect(json['name']).to eql('script')
        end
    end

    context 'GET #destroy' do
        it 'destroy scripts' do
            delete '/api/v1/scripts/1'
            expect(json['message']).to eql('Script deleted')
        end
    end

    context 'POST #create' do
        it 'create scripts' do
            params = { name: 'script' }
            post '/api/v1/scripts', params: params.to_json, headers: request_header
            expect(json['name']).to eql('script')
        end
    end

    context "PATCH #upgrate" do
        it "Update scripts" do
            params = {name: 'scripts'}
            patch '/api/v1/scripts/1', params: params.to_json, headers: request_header
            expect(json['name']).to eql('scripts')
        end
    end

end
