require 'rails_helper'

RSpec.describe Alarm, type: :model do
    before :all do
        @ns = NetworkService.create(name: "ns")
        @pop = Pop.create(name: "pop", ip: "ip", instance: "AWS")
        @vnf = Vnf.new(name: 'vnf', cores: 1, ram: 1024, disc: 5)
        @ns.vnfs << @vnf
        @pop.vnfs << @vnf
        @vnf.save
    end

    context 'ensure parameters' do
        it 'ensure vnf' do
            @alarm = Alarm.new(name: "alarm")
            expect(@alarm.save).to eql(false)
        end

        it "ensure vnf" do
            @alarm = Alarm.new(name: "alarm")
            @vnf.alarms << @alarm
            expect(@alarm.save).to eql(true)
        end
    end
end

