# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Cat.destroy_all

cat1 = Cat.create(color: 'black', birth_date: '2001/09/11', sex: 'M', name: 'Tim',
  description: 'Gave us hope that day')

cat2 = Cat.create(color: 'white', birth_date: '1997/10/17', sex: 'M', name: 'Umarbin',
  description: 'Worst day of my life')

cat3 = Cat.create(color: 'orange', birth_date: '1997/10/17', sex: 'M', name: 'Andy',
  description: 'G\'day mate')

cat4 = Cat.create(color: 'brown', birth_date: '1997/10/17', sex: 'F', name: 'David',
  description: 'David the lady')