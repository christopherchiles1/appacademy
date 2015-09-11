# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = User.create!([
  {
    email: 'bob@aol.com'
  },
  {
    email: 'stuff@gmail.com'
  }
  ])

shortened_urls = ShortenedUrl.create!([
  {
    long_url: 'www.gmail.com',
    short_url: ShortenedUrl.random_code,
    submitter_id: 1
  },
  {
    long_url: 'www.amazon.com',
    short_url: ShortenedUrl.random_code,
    submitter_id: 1
  }
  ])

visits = Visit.create!([
  {
    visitor_id: 2,
    shortened_url_id: 2
  },
  {
    visitor_id: 2,
    shortened_url_id: 2
  },
  {
    visitor_id: 1,
    shortened_url_id: 2
  }
  ])
