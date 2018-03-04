require 'rails_helper'

RSpec.describe Rrh, type: :model do
    context 'ensure parameters' do
        it 'ensure name' do
            @pop = Pop.new(ip: "1234", instance: "OpenStack").save
            expect(@pop).to eql(false)
        end

        it 'ensure IP presence' do
            @pop = Pop.new(name: 'pop1', instance: "OpenStack").save
            expect(@pop).to eql(false)
        end
        
        it 'ensure instance' do
            @pop = Pop.new(name: "pop1", ip: "1234").save
            expect(@pop).to eql(false)
        end

        it 'ensure instance format' do
            @pop1 = Pop.new(name: 'pop1', ip: "1234", instance: "OpenStack").save
            @pop2 = Pop.new(name: 'pop2', ip: "1234", instance: "GCE").save
            @pop3 = Pop.new(name: 'pop3', ip: "1234", instance: "AWS").save
            expect(@pop1).to eql(true)
            expect(@pop2).to eql(true)
            expect(@pop3).to eql(true)
        end

        it 'ensure false format' do
            @pop = Pop.new(name: 'pop1', ip: "1234", instance: "Another").save
            expect(@pop).to eql(false)
        end
    end
end
