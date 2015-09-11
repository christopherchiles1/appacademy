require_relative 'questions_database'

class QuestionLike
  attr_accessor :id, :user_id, :question_id

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id).first
      SELECT
        *
      FROM
        question_likes
      WHERE
        id = ?;
    SQL
    return unless data
    QuestionLike.new(data)
  end

  def self.likers_for_question_id(question_id)
    records = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        users
      JOIN
        question_likes ON users.id = question_likes.user_id
      WHERE
        question_likes.question_id = ?;
    SQL

    records.map { |record| User.new(record) }
  end

  def self.num_likes_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id).first
      SELECT
        COUNT(question_likes.id) AS num_likes
      FROM
        users
      JOIN
        question_likes ON users.id = question_likes.user_id
      WHERE
        question_likes.question_id = ?
      GROUP BY
        question_likes.id;
    SQL

    return 0 unless data
    data['num_likes']
  end

  def self.liked_questions_for_user_id(user_id)
    records = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        questions
      JOIN
        question_likes ON questions.id = question_likes.question_id
      WHERE
        question_likes.user_id = ?;
    SQL

    records.map { |record| Question.new(record) }
  end

  def self.most_liked_questions(n)
    records = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.*
      FROM
        questions
      JOIN
        question_likes ON questions.id = question_likes.question_id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(question_likes.id) DESC
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
