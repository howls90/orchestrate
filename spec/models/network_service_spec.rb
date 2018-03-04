require 'rails_helper'

RSpec.describe NetworkService, type: :model do
    context 'ensure parameters' do
        it 'ensure name' do
            @ns = NetworkService.new().save
            expect(@ns).to eql(false)
        end

        it 'ensure add vnf' do
            @pop = Pop.create(name: "pop1", ip: "192.168.1.3", instance: "AWS")
            @ns = NetworkService.create(name: "ns1")
            @vnf = Vnf.new(name: "ee", cores: 1, ram: 1024, disc: 5)
            @ns.vnfs << @vnf
            @pop.vnfs << @vnf
            expect(@ns.vnfs.count).to eql(1)
        end
    end
end
