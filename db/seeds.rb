# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@eetac = Scenario.create(name: 'eetac')

@rrh = @eetac.rrhs.create(ip: '192.168.1.2', 
                          version: '1.2', 
                          model: "usrp", 
                          latitude: -10.4, 
                          longitude: -50)

@ns = NetworkService.create(name: "ns")

@pop = Pop.create(name: "pop1", ip: "192.168.1.1", instance: "AWS")

@vnf = Vnf.new(name: "vnf", cores: 1, ram: 1024, disc: 5)
@ns.vnfs << @vnf
@pop.vnfs << @vnf
@vnf.save

@alarm = Alarm.new(name: "alarm")
@vnf.alarms << @alarm
@alarm.save

@script = Script.new(name: "script", 
                     provider: "Ansible", 
                     configuration: "sudo apt-get update")
@vnf.scripts << @script
@script.save

User.create(email: 'oocran@mail.com' , password: 'oocran' , password_confirmation: 'oocran')
