# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
jane = User.create({name: "Jane"})
peter = User.create({name: "Peter"})
luke = User.create({name: "Luke"})

main_office = CompanyNumber.create({name: 'main office'})
sales = CompanyNumber.create({name: 'sales'})
support = CompanyNumber.create({name: 'support'})

main_office.users << jane << peter << luke
sales.users << jane << luke
support.users << peter

 UserNumber.create({user: jane, name: 'desktop'})
 UserNumber.create({user: jane, name: 'mobile'})
 UserNumber.create({user: jane, name: 'fixed'})
 UserNumber.create({user: peter, name: 'mobile'})
 UserNumber.create({user: peter, name: 'desktop'})
 UserNumber.create({user: luke, name: 'desktop'})
