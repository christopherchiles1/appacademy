require_relative 'questions_database'
require_relative 'question'
require_relative 'reply'
require_relative 'question_follow'
require_relative 'question_like'

class User
  attr_accessor :id, :fname, :lname

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id).first
      SELECT
        *
      FROM
        users
      WHERE
        id = ?;
    SQL
    return unless data
    User.new(data)
  end

  def self.find_by_name(fname, lname)
    records = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?;
    SQL
    records.map { |record| User.new(record) }
  end

  def initialize(attributes)
    @id = attributes['id']
    @fname = attributes['fname']
    @lname = attributes['lname']
  end

  def save
    if id.nil?
      #insert into database
      QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
        INSERT INTO
          users (fname, lname)
        VALUES
          (?, ?);
      SQL

      @id = QuestionsDatabase.instance.last_insert_row_id
    else
      #update in database
      QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
        UPDATE
          users (fname, lname)
        SET
          fname = ?,
          lname = ?
        WHERE
          users.id = #{id};
      SQL
    end
  end

  def authored_questions
    Question.find_by_author_id(id)
  end

  def authored_replies
    Reply.find_by_user_id(id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(id)
  end

  def average_karma
    data = QuestionsDatabase.instance.execute(<<-SQL).first
      SELECT
        (CAST(COUNT(question_likes.id) AS FLOAT) /
        COUNT(DISTINCT(questions.id))) AS average_karma
      FROM
        questions
      LEFT OUTER JOIN
        question_likes ON questions.id = question_likes.question_id
      WHERE
        questions.author_id = #{id}
    SQL

    return 0 unless data
    data['average_karma']
  end
end
