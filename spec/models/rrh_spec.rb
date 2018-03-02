require 'rails_helper'

RSpec.describe Rrh, type: :model do
    before :all do
        Scenario.create(name: 'eetac')
    end

    context 'ensure parameters' do
        it 'ensure model' do
            rrh = Rrh.new(ip: '192.168.1.2', version: '1.2', latitude: -10.4, longitude: -50, scenario_id: 1).save
            expect(rrh).to eql(false)
        end

        it 'ensure IP presence' do
            rrh = Rrh.new(version: '192.168.1.2', model: 'Ursp', latitude: -10.4, longitude: -50, scenario_id: 1).save
            expect(rrh).to eql(false)
        end

        it 'ensure IP format' do
            rrh = Rrh.new(version: '1.2', model: 'USRP', ip: '12.3', latitude: -10.4, longitude: -50, scenario_id: 1).save
            expect(rrh).to eql(false)
        end

        it 'ensure version' do
            rrh = Rrh.new(ip: "192.168.1.3", model:"USRP", latitude: -10.4, longitude: -50, scenario_id: 1).save
            expect(rrh).to eql(false)
        end

        it 'ensure latitude' do
            rrh = Rrh.new(ip: "192.168.1.1", model: "USRP", version: "1.2", latitude: -120.4, longitude: 90, scenario_id: 1).save
            expect(rrh).to eql(false)
        end

        it 'ensure longitude' do
            rrh = Rrh.new(ip: "192.168.1.1", model: "USRP", version: "1.2", latitude: 90.4, longitude: 900.4, scenario_id: 1).save
            expect(rrh).to eql(false)
        end

        it 'ensure scenario id' do
            rrh = Rrh.new(ip: "192.168.1.1", model: "USRP", version: "1.2", latitude: 90.4, longitude: 900.4).save
            expect(rrh).to eql(false)
        end

        it 'save correctly' do
            rrh = Rrh.new(ip: '192.168.1.4', model: '1.2', version: '1.2', latitude: -10.4, longitude: -50, scenario_id: 1).save
            expect(rrh).to eql(true)
        end
    end
end
