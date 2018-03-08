require 'rails_helper'

RSpec.describe Vnf, type: :model do
    before :all do
        @user = User.create(email: "oocran@example.com", password: "oocran", password_confirmation: "oocran")
        @ns = @user.network_services.create(name: 'ns1')
        @pop = Pop.create(name: 'pop1', ip: "128.123.123.1", instance: "AWS")
    end
    after :all do
        @user.destroy
        @ns.destroy
        @pop.destroy
    end

    context 'ensure parameters' do
        it 'ensure name' do
            vnf = Vnf.new(cores: 1, ram: 1024, disc: 5)
            expect(vnf.save).to eql(false)
        end

        it 'ensure cores' do
            vnf = Vnf.new(name: "vnf", ram: 1024, disc: 5)
            expect(vnf.save).to eql(false)
        end

        it 'ensure ram' do
            vnf = Vnf.new(name: "vnf", cores: 1, disc: 5)
            expect(vnf.save).to eql(false)
        end

        it 'ensure disc' do
            vnf = Vnf.new(name: "vnf", cores: 1, ram: 1024, disc: 5)
            expect(vnf.save).to eql(false)
        end

        it 'ensure save correctly' do
            vnf = @user.vnfs.create(name: "vnf", cores: 1, ram: 1024, disc: 5)
            @pop.vnfs << vnf
            @ns.vnfs << vnf
            expect(vnf.save).to eql(true)
        end

        it 'ensure network service ID false' do
            vnf = Vnf.new(name: "vnf", cores: 1, ram: 1024, disc: 5)
            @pop.vnfs << vnf
            expect(vnf.save).to eql(false)
        end

        it 'ensure pop ID false' do
            vnf = Vnf.new(name: "vnf", cores: 1, ram: 1024, disc: 5)
            @ns.vnfs << vnf
            expect(vnf.save).to eql(false)
        end
    end
end
