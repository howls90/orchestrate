# require 'rails_helper'

# RSpec.describe Alarm, type: :model do
#     before :all do
#         @vnf = Vnf.create(name: "vnf", cpu: 1, ram: 1024, disc: 50, url_server: "zabbix", state: "Running", pop_id: @pop.id, ns_id: @ns.id)
#         @alarm = Alarm.create(name: "eetac", vnf_id: @vnf.id)
#     end

#     context 'ensure parameters' do
#         it 'ensure model name' do
#             alarm = Alarm.create(description: "test1", vnf_id: @vnf.id )
#             expect(alarm).to eql(false)
#         end

#         it "ensure vnf or network service presence" do
#             alarm = Alarm.new(name: "vnf1").save
#             expect(alarm).to eql(false)
#         end

#         it "ensure vnf" do
#             alarm = Alarm.new(name: "vnf1", vnf_id: @vnf.id)
#             expect(alarm).to eql(true)
#         end

#         it "ensure network service" do
#             alarm = Alarm.new(name: "vnf1", network_service: @network_service.id)
#             expect(alarm).to eql(true)
#         end
#     end
# end

