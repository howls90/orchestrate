require 'rails_helper'
require './spec/support/auth_helpers'

RSpec.configure do |c|
  c.include AuthHelpers
end

RSpec.describe 'VNF API' do
    before(:all) do
      @jwt = auth()
      @pop = Pop.create(name: "pop1", ip: "192.168.1.1", instance: "OpenStack")
      @ns = @user.network_services.create(name: "ns1")
      @vnf = @ns.vnfs.new(name: "vnf", cores: 1, ram: 1024, disc: 5)
      @user.vnfs << @vnf
      @pop.vnfs << @vnf
      @vnf.save
    end
    after :all do
      @user.destroy  
      @pop.destroy
      @ns.destroy
      @vnf.destroy
    end
    let(:json) {JSON.parse(response.body)}
    let(:request_header) do 
      {'CONTENT_TYPE' => 'application/json', 
       'ACCEPT' => 'application/json',
       "Authorization" => "Authorization: #{@jwt}" }
    end

    context "GET #index" do
        it 'return all vnfs' do
            get "/api/v1/network_services/#{@ns.id}/vnfs",
                headers: { "Authorization" => "Authorization: #{@jwt}" }
            expect(json[0]['id']).to eql(@vnf.id)
        end
    end

    context "GET #show" do
        it 'show request' do
            get "/api/v1/network_services/#{@ns.id}/vnfs/#{@vnf.id}",
                headers: { "Authorization" => "Authorization: #{@jwt}" }
            expect(json['name']).to eql("vnf")
            expect(json['cores']).to eql(1)
            expect(json['ram']).to eql(1024)
            expect(json['disc']).to eql(5)
            expect(json['status']).to eql("Shut Down")
        end
    end

    context 'GET #destroy' do
        it 'destroy vnf' do
            delete "/api/v1/network_services/#{@ns.id}/vnfs/#{@vnf.id}",
                   headers: { "Authorization" => "Authorization: #{@jwt}" }
            expect(json['message']).to eql('VNF deleted')
        end
    end

    context 'POST #create' do
        it 'create vnf' do
            params = { name: 'vnf2', cores: 1, ram: 1025, disc: 5, pop_id: @pop.id }
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
