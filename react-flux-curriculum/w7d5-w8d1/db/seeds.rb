200.times do
  Bench.create!(
    { description: Faker::Lorem.sentence,
      lat: Faker::Address.latitude,
      lon: Faker::Address.longitude,
      seating: rand(6) + 1
    }
  )
end
