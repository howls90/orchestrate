require 'rails_helper'

require './spec/support/auth_helpers'

RSpec.configure do |c|
    c.include AuthHelpers
end

RSpec.describe Alarm, type: :model do
    before :all do
        @user = User.create(email: "oocran@example.com", password: "oocran", password_confirmation: "oocran")
        @ns = @user.network_services.create(name: "ns")
        @pop = Pop.create(name: "pop", ip: "ip", instance: "AWS")
        @vnf = @user.vnfs.new(name: 'vnf', cores: 1, ram: 1024, disc: 5)
        @ns.vnfs << @vnf
        @pop.vnfs << @vnf
        @vnf.save
    end
    after :all do
        @user.destroy
        @ns.destroy
        @vnf.destroy
        @pop.destroy
    end

    context 'ensure parameters' do
        it 'ensure vnf' do
            @alarm = @user.alarms.new(name: "alarm")
            @vnf.alarms << @alarm
            expect(@alarm.save).to eql(true)
        end

        it "ensure vnf" do
            @alarm = @user.alarms.new(name: "alarm1")
            @vnf.alarms << @alarm
            expect(@alarm.save).to eql(true)
        end
    end
end

