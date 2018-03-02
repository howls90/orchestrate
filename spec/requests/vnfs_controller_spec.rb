require 'rails_helper'

RSpec.describe 'VNF API' do
    before(:all) do
        @ns = NetworkService.create(name: "ns1")
        @vnf = @ns.vnfs.create(name: "vnf", cpu: 1, ram: 1024, disc: 5, status: "Shutdown")
    end 
    let(:json) {JSON.parse(response.body)}
    let(:request_header) do 
        {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
    end

    context "GET #index" do
        it 'return all vnfs' do
            get "/api/v1/network_services/#{@ns.id}/vnfs"
            expect(json[0]['name']).to eql("vnf")
        end
    end

    context "GET #show" do
        it 'show request' do
            get "/api/v1/network_services/#{@ns.id}/vnfs/#{@vnf.id}"
            expect(json['name']).to eql("vnf")
            expect(json['cpu']).to eql(1)
            expect(json['ram']).to eql(1024)
            expect(json['disc']).to eql(5)
            expect(json['status']).to eql("Shutdown")
        end
    end

    context 'GET #destroy' do
        it 'destroy vnf' do
            delete "/api/v1/network_services/#{@ns.id}/vnfs/#{@vnf.id}"
            expect(json['message']).to eql('VNF deleted')
        end
    end

    context 'POST #create' do
        it 'create vnf' do
            params = { name: 'vnf2' }
            post "/api/v1/network_services/#{@ns.id}/vnfs", 
                params: params.to_json, 
                headers: request_header
            expect(json['name']).to eql('vnf2')
        end
    end

    context "PATCH #upgrade" do
        it "Edit vnf" do
            params = {name: 'vnf3'}
            patch "/api/v1/network_services/#{@ns.id}/vnfs/#{@vnf.id}", 
                params: params.to_json, 
                headers: request_header
            expect(json['name']).to eql('vnf3')
        end
    end

end
