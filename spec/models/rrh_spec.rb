require 'rails_helper'

RSpec.describe Rrh, type: :model do
    before :all do
        @scenario = Scenario.new(name: 'eetac')
    end
    after :all do
        @scenario.destroy
    end

    context 'ensure parameters' do
        it 'ensure model' do
            rrh = @scenario.rrhs.new(ip: '192.168.1.2', version: '1.2', latitude: -10.4, longitude: -50)
            expect(rrh.save).to eql(false)
        end

        it 'ensure IP presence' do
            rrh = @scenario.rrhs.new(version: '1.2', model: 'Ursp', latitude: -10.4, longitude: -50)
            expect(rrh.save).to eql(false)
        end

        it 'ensure IP format' do
            rrh = @scenario.rrhs.new(version: '1.2', model: 'USRP', ip: '12.3', latitude: -10.4, longitude: -50)
            expect(rrh.save).to eql(true)
        end

        it 'ensure version' do
            rrh = @scenario.rrhs.new(ip: "192.168.1.3", model:"USRP", latitude: -10.4, longitude: -50)
            expect(rrh.save).to eql(false)
        end

        it 'ensure latitude' do
            rrh = @scenario.rrhs.new(ip: "192.168.1.1", model: "USRP", version: "1.2", latitude: -120.4, longitude: 90,)
            expect(rrh.save).to eql(false)
        end

        it 'ensure longitude' do
            rrh = @scenario.rrhs.new(ip: "192.168.1.1", model: "USRP", version: "1.2", latitude: 90.4)
            expect(rrh.save).to eql(false)
        end

        it 'ensure scenario id' do
            rrh = @scenario.rrhs.new(ip: "192.168.1.1", model: "USRP", version: "1.2", latitude: 90.4, longitude: 900.4)
            expect(rrh.save).to eql(false)
        end

        it 'save correctly' do
            rrh = @scenario.rrhs.new(ip: '192.168.1.4', model: '1.2', version: '1.2', latitude: -10.4, longitude: -50)
            expect(rrh['id']).to eql(rrh.id)
        end
    end
end
