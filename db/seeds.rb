# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create([
              { username: 'tester', first_name: 'test', last_name: 'user', email: 'insta@test.com',
                password: '123456' },
              { username: 'IbrahimTG99', first_name: 'Ibrahim', last_name: 'Tariq', email: 'dexter@test.com',
                password: 'password' },
              { username: 'jonnyboy', first_name: 'Jhon', last_name: 'Snow', email: 'jonny@test.com',
                password: 'password' },
              { username: 't2', first_name: 'test', last_name: 'the second', email: 'yoyo@test.com',
                password: 'password' }
            ])
