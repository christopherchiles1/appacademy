1000.times do
  Bench.create!(
    { description: Faker::Lorem.sentence,
      lat: Faker::Address.latitude,
      lon: Faker::Address.longitude
    }
  )
end
