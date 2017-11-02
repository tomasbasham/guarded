# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

picard = User.create(email: 'jeanlucpicard@starfleet.com', password: 'piccolo', password_confirmation: 'piccolo')
data = User.create(email: 'data@starfleet.com', password: 'violin', password_confirmation: 'violin')

Post.create(title: 'title1', body: 'body1', published: true, user: picard)
Post.create(title: 'title2', body: 'body2', published: true, user: picard)
Post.create(title: 'title3', body: 'body3', published: true, user: picard)

Post.create(title: 'title4', body: 'body4', published: true, user: data)
Post.create(title: 'title5', body: 'body5', published: true, user: data)
