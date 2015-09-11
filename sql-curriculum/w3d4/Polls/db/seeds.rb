# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = User.create!([
  { user_name: 'fuzzybunny123' },
  { user_name: 'fathippo456' },
  { user_name: 'cat_lover5' },
  { user_name: 'charles_the_ta' }
  ]).to_a

polls = Poll.create!([
  { title: 'TA Survey', author_id: users.last.id },
  { title: 'Which famous bunny are you?', author_id: users.first.id }
  ])

questions1 = polls.first.questions.create!([
  { text: 'Rate your TA (1 - 3 stars)' },
  { text: 'Would you like to work with this TA again?' }
  ])
questions2 = polls.last.questions.create!([
  { text: 'Do you hop or run?' },
  { text: 'Do you the art enjoy painting of the eggs?' }
  ])

answer_choices = AnswerChoice.create!([
  { text: '1 star', question: questions1.first},
  { text: '2 star', question: questions1.first},
  { text: '3 star', question: questions1.first},
  { text: 'Yes', question: questions1.last} ,
  { text: 'No', question: questions1.last} ,
  { text: 'I hop', question: questions2.first} ,
  { text: 'I run', question: questions2.first} ,
  { text: 'Yes, painting is awesome to the eggs.', question: questions2.last} ,
  { text: 'No. Never.', question: questions2.last}
  ]).to_a

responses = Response.create!([
  { respondent: users[1], answer_choice: answer_choices.first },
  { respondent: users[1], answer_choice: answer_choices[4] },
  { respondent: users[2], answer_choice: answer_choices[5] },
  { respondent: users[2], answer_choice: answer_choices[7] }
  ])
