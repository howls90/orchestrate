require 'rails_helper'
require './spec/support/auth_helpers'

RSpec.configure do |c|
    c.include AuthHelpers
end

RSpec.describe 'alarms API' do
    before :all do
        @jwt = auth()
        @ns = @user.network_services.create(name: "ns")
        @pop = Pop.create(name: "pop", ip: "ip", instance: "AWS")
        
        @vnf = @user.vnfs.new(name: 'vnf', cores: 1, ram: 1024, disc: 5)
        @ns.vnfs << @vnf
        @pop.vnfs << @vnf
        @vnf.save
        
        @alarm = @user.alarms.new(name: "alarm1")
        @vnf.alarms << @alarm
        @alarm.save
    end
    after :all do
       @vnf.destroy
       @ns.destroy
       @pop.destroy
       @user.destroy
       @alarm.destroy
    end
    let(:json) {JSON.parse(response.body)}
    let(:request_header) do 
        {'CONTENT_TYPE' => 'application/json', 
         'ACCEPT' => 'application/json',
         "Authorization" => "Authorization: #{@jwt}" }
    end

    context "GET #index" do
        it 'return all alarms' do
            get '/api/v1/alarms', 
                headers: { "Authorization" => "Authorization: #{@jwt}" }
            expect(json[0]['id']).to eql(@alarm.id)
        end
    end

    context "GET #show" do
        it 'show request' do
            get "/api/v1/alarms/#{@alarm.id}", 
                headers: { "Authorization" => "Authorization: #{@jwt}" }
            expect(json['name']).to eql('alarm1')
        end
    end

    context 'GET #destroy' do
        it 'destroy alarms' do
            delete "/api/v1/alarms/#{@alarm.id}", 
                headers: { "Authorization" => "Authorization: #{@jwt}" }
            expect(json['message']).to eql('Alarm deleted')
        end
    end

    context 'POST #create' do
        it 'create alarms' do
            params = { name: 'alarm2', vnf_id: @vnf.id }
            post '/api/v1/alarms', 
                params: params.to_json, 
                headers: request_header
            expect(json['name']).to eql('alarm2')
        end
    end

    context "PATCH #updade" do
        it "Update alarms" do
            params = {name: 'alarms3', vnf_id: @vnf.id}  
            patch "/api/v1/alarms/#{@alarm.id}", 
                params: params.to_json, 
                headers: request_header
            expect(json['name']).to eql('alarms3')
        end
    end

 end
