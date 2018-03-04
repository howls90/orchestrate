require 'rails_helper'

RSpec.describe Vnf, type: :model do
    before :all do
        @ns = NetworkService.create(name: 'ns1')
        @pop = Pop.create(name: 'pop1', ip: "128.123.123.1", instance: "AWS")
    end

    context 'ensure parameters' do
        it 'ensure name' do
            @vnf = Vnf.new(cores: 1, ram: 1024, disc: 5).save
            expect(@vnf).to eql(false)
        end

        it 'ensure cores' do
            @vnf = Vnf.new(name: "vnf", ram: 1024, disc: 5).save
            expect(@vnf).to eql(false)
        end

        it 'ensure ram' do
            @vnf = Vnf.new(name: "vnf", cores: 1, disc: 5).save
            expect(@vnf).to eql(false)
        end

        it 'ensure disc' do
            @vnf = Vnf.new(name: "vnf", cores: 1, ram: 1024, disc: 5).save
            expect(@vnf).to eql(false)
        end

        it 'ensure save correctly' do
            @vnf = Vnf.new(name: "vnf", cores: 1, ram: 1024, disc: 5)
            @pop.vnfs << @vnf
            @ns.vnfs << @vnf
            expect(@vnf.save).to eql(true)
        end

        it 'ensure network service ID false' do
            @vnf = Vnf.new(name: "vnf", cores: 1, ram: 1024, disc: 5)
            @pop.vnfs << @vnf
            expect(@vnf.save).to eql(false)
        end

        it 'ensure pop ID false' do
            @vnf = Vnf.new(name: "vnf", cores: 1, ram: 1024, disc: 5)
            @ns.vnfs << @vnf
            expect(@vnf.save).to eql(false)
        end
    end
end
