25.times do
  Todo.create!(
    title: Faker::Hacker.verb,
    body: Faker::Hacker.say_something_smart,
    done: false
  )
end
