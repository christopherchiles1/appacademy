require_relative 'questions_database'
require_relative 'user'
require_relative 'question'

class QuestionFollow
  attr_accessor :id, :user_id, :question_id

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id).first
      SELECT
        *
      FROM
        question_follows
      WHERE
        id = ?;
    SQL
    return unless data
    QuestionFollow.new(data)
  end

  def self.followers_for_question_id(question_id)
    records = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        users
      JOIN
        question_follows ON users.id = question_follows.user_id
      WHERE
        question_follows.question_id = ?;
    SQL

    records.map { |record| User.new(record) }
  end

  def self.followed_questions_for_user_id(user_id)
    records = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        questions
      JOIN
        question_follows ON questions.id = question_follows.question_id
      WHERE
        question_follows.user_id = ?;
    SQL

    records.map { |record| Question.new(record) }
  end

  def self.most_followed_questions(n)
    records = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.*
      FROM
        questions
      JOIN
        question_follows ON questions.id = question_follows.question_id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(question_follows.id) DESC
      LIMIT
        ?;
    SQL

    records.map { |record| Question.new(record) }
  end

  def initialize(attributes)
    @id = attributes['id']
    @user_id = attributes['user_id']
    @question_id = attributes['question_id']
  end
end
