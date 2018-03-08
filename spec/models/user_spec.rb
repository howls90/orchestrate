require 'rails_helper'

RSpec.describe User, type: :model do
    context 'ensure create' do
        it 'create succesfully' do
            user = User.new(email: "oocran@example.com", password: "oocran", password_confirmation: "oocran")
            expect(user.save).to eql(true)
        end

        it 'ensure password exist' do 
            user = User.new(email: "oocran@example.com", password: "oocran")
            expect(user.save).to eql(true)
        end
    end
end
