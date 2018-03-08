require 'rails_helper'

RSpec.describe NetworkService, type: :model do
    before :all do
        @user = User.create(email: "oocran@example.com", password: "oocran", password_confirmation: "oocran")
        @pop = Pop.create(name: "pop", ip: "ip", instance: "AWS")
        @vnf = @user.vnfs.new(name: 'vnf', cores: 1, ram: 1024, disc: 5)
    end
    after :all do
        @user.destroy
        @pop.destroy
        @vnf.destroy
    end
    context 'ensure parameters' do
        it 'ensure name' do
            @ns = @user.network_services.new()
            expect(@ns.save).to eql(false)
        end

        it 'ensure add vnf' do
            @ns = @user.network_services.create(name: "ns1")
            @ns.vnfs << @vnf
            @pop.vnfs << @vnf
            expect(@vnf.save).to eql(true)
        end
    end
end
