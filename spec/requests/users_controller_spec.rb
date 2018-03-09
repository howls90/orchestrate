require 'rails_helper'
require './spec/support/auth_helpers'

RSpec.configure do |c|
    c.include AuthHelpers
end

RSpec.describe 'users API' do
    before :all do
        @jwt = auth()
    end
    after :all do
       @user.destroy
    end
    let(:json) {JSON.parse(response.body)}
    let(:request_header) do 
        {'CONTENT_TYPE' => 'application/json', 
         'ACCEPT' => 'application/json',
         "Authorization" => "Authorization: #{@jwt}" }
    end

    context "GET #index" do
        it 'return all users' do
            get '/api/v1/users', 
                headers: { "Authorization" => "Authorization: #{@jwt}" }
            expect(json[0]['email']).to eql(@user.email)
        end
    end

    context "GET #show" do
        it 'show request' do
            get "/api/v1/users/#{@user.id}", 
                headers: { "Authorization" => "Authorization: #{@jwt}" }
                expect(json['email']).to eql(@user.email)
        end
    end

    context 'GET #destroy' do
        it 'destroy users' do
            delete "/api/v1/users/#{@user.id}", 
                headers: { "Authorization" => "Authorization: #{@jwt}" }
            expect(json['message']).to eql('User deleted')
        end
    end

    context 'POST #create' do
        it 'create users' do
            params = { email: 'user3@example.com', password: "user3", password_confirmation: "user3" }
            post '/api/v1/users', 
                params: params.to_json, 
                headers: request_header
            expect(json['email']).to eql('user3@example.com')
        end
    end

    context "PATCH #updade" do
        it "Update users" do
            params = { email: 'user3@example.com', password: "user3", password_confirmation: "user3" }
            patch "/api/v1/users/#{@user.id}", 
                params: params.to_json, 
                headers: request_header
            expect(json['email']).to eql('user3@example.com')
        end
    end

 end
