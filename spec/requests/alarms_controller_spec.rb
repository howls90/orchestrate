require 'rails_helper'

RSpec.describe 'alarms API' do
    before(:all) do
        @ns = NetworkService.create(name: "ns")
        @pop = Pop.create(name: "pop", ip: "ip", instance: "AWS")
        @vnf = Vnf.new(name: 'vnf', cores: 1, ram: 1024, disc: 5)
        @ns.vnfs << @vnf
        @pop.vnfs << @vnf
        @vnf.save
        @alarm = Alarm.new(name: "alarm1")
        @vnf.alarms << @alarm
        @alarm.save
    end 
    let(:json) {JSON.parse(response.body)}
    let(:request_header) do 
        {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
    end

    context "GET #index" do
        it 'return all alarms' do
            get '/api/v1/alarms'
            expect(json[0]['name']).to eql('alarm1')
        end
    end

    context "GET #show" do
        it 'show request' do
            get "/api/v1/alarms/#{@alarm.id}"
            expect(json['name']).to eql('alarm1')
        end
    end

    context 'GET #destroy' do
        it 'destroy alarms' do
            delete "/api/v1/alarms/#{@alarm.id}"
            expect(json['message']).to eql('Alarm deleted')
        end
    end

    context 'POST #create' do
        it 'create alarms' do
            params = { name: 'alarm2', vnf_id: @vnf.id }
            post '/api/v1/alarms', params: params.to_json, headers: request_header
            expect(json['name']).to eql('alarm2')
        end
    end

    context "PATCH #updade" do
        it "Update alarms" do
            params = {name: 'alarms3', vnf_id: @vnf.id}  
            patch "/api/v1/alarms/#{@alarm.id}", params: params.to_json, headers: request_header
            expect(json['name']).to eql('alarms3')
        end
    end

 end
