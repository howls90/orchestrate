require 'rails_helper'

RSpec.describe "Rrhs API" do
    before(:all) do
        @scenario = Scenario.create(name: "eetac")
        @rrh = @scenario.rrhs.create(ip: "192.168.1.2", 
                                    version: '1.2', 
                                    model: 'usrp', 
                                    latitude: -10.4, 
                                    longitude: -50.0)
    end 
    let(:json) {JSON.parse(response.body)}
    let(:request_header) do
        {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
    end

    context "GET #index" do
        it "return all rrhs" do
            get "/api/v1/scenarios/#{@scenario.id}/rrhs"
            expect(json[0]['version']).to eql('1.2') 
         end
    end

    context "PATCH #upgrade" do
        it "Update Radio Remote Head" do
            params = {ip: '192.168.30.1'}
            patch "/api/v1/scenarios/#{@scenario.id}/rrhs/#{@rrh.id}", 
                   params: params.to_json, headers: request_header
            expect(json['ip']).to eql('192.168.30.1')
        end
    end

    context "GET #show" do
        it 'check rrh content' do
            get "/api/v1/scenarios/#{@scenario.id}/rrhs/#{@rrh.id}"
            expect(json['ip']).to eql('192.168.1.2')
            expect(json['version']).to eql('1.2')
            expect(json['model']).to eql('usrp')
            expect(json['latitude']).to eql(-10.4)
            expect(json['longitude']).to eql(-50.0)
        end
    end

    context "POST #create" do
        it "create rrh" do
            params = {ip: "192.168.1.4", model: "1.3", version: "1.2", latitude: -10.0, longitude: 50.0}
            post "/api/v1/scenarios/#{@scenario.id}/rrhs", 
                 params: params.to_json, headers: request_header
            expect(json['ip']).to eql('192.168.1.4')
        end
    end

    context "GET #destroy" do
        it "delete rrh" do
            delete "/api/v1/scenarios/#{@scenario.id}/rrhs/#{@rrh.id}"
            expect(json['message']).to eql('RRH deleted')
        end
    end
end
