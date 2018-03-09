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
        
        it 'ensure user password' do 
            user = User.create(email: "admin@example.com", password: "admin", password_confirmation: "admin", is_admin: true)
            expect(user.is_admin).to eql(true)
        end
    end
end
