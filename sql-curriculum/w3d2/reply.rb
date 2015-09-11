require_relative 'questions_database'
require_relative 'user'
require_relative 'question'


class Reply
  attr_accessor :id, :question_id, :parent_id, :user_id, :body

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id).first
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?;
    SQL
    return unless data
    Reply.new(data)
  end

  def self.find_by_user_id(user_id)
    records = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?;
    SQL
    records.map { |record| Reply.new(record) }
  end

  def self.find_by_question_id(question_id)
    records = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?;
    SQL
    records.map { |record| Reply.new(record) }
  end

  def initialize(attributes)
    @id = attributes['id']
    @question_id = attributes['question_id']
    @parent_id = attributes['parent_id']
    @user_id = attributes['user_id']
    @body = attributes['body']
  end

  def author
    User.find_by_id(user_id)
  end

  def question
    Question.find_by_id(question_id)
  end

  def parent_reply
    Reply.find_by_id(parent_id)
  end

  def child_replies
    records = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_id = ?;
    SQL
    records.map { |record| Reply.new(record) }
  end

end
