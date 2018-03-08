require 'rails_helper'
require './spec/support/auth_helpers'

RSpec.configure do |c|
    c.include AuthHelpers
end

RSpec.describe 'Scripts API' do
    before :all do
        @jwt = auth()
        @script = @user.scripts.create(name: "script", provider: "ansible", configuration: "test")
    end
    after :all do
       @user.destroy
       @script.destroy
    end 
    let(:json) {JSON.parse(response.body)}
    let(:request_header) do 
        {'CONTENT_TYPE' => 'application/json', 
         'ACCEPT' => 'application/json',
         "Authorization" => "Authorization: #{@jwt}" }
    end

    context "GET #index" do
        it 'return all scripts' do
            get '/api/v1/scripts',
            headers: { "Authorization" => "Authorization: #{@jwt}" }
            expect(json[0]['id']).to eql(@script.id)
        end
    end

    context "GET #show" do
        it 'show request' do
            get "/api/v1/scripts/#{@script.id}",
            headers: { "Authorization" => "Authorization: #{@jwt}" }
            expect(json['name']).to eql(@script.name)
        end
    end

    context 'GET #destroy' do
        it 'destroy scripts' do
            delete "/api/v1/scripts/#{@script.id}",
            headers: { "Authorization" => "Authorization: #{@jwt}" }
            expect(json['message']).to eql('Script deleted')
        end
    end

    context 'POST #create' do
        it 'create scripts' do
            params = { name: 'script2', provider: "ansible", configuration: "test" }
            post '/api/v1/scripts', params: params.to_json, headers: request_header
            expect(json['name']).to eql(params[:name])
        end
    end

    context "PATCH #upgrate" do
        it "Update scripts" do
            params = {name: 'scripts'}
            patch "/api/v1/scripts/#{@script.id}", params: params.to_json, headers: request_header
            expect(json['name']).to eql(params[:name])
        end
    end

end
