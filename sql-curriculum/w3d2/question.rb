require_relative 'questions_database'
require_relative 'user'
require_relative 'reply'
require_relative 'question_follow'
require_relative 'question_like'

class Question
  attr_accessor :id, :title, :body, :author_id

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id).first
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?;
    SQL
    return unless data
    Question.new(data)
  end

  def self.find_by_author_id(author_id)
    records = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        author_id = ?;
    SQL
    records.map { |record| Question.new(record) }
  end

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  def initialize(attributes)
    @id = attributes['id']
    @title = attributes['title']
    @body = attributes['body']
    @author_id = attributes['author_id']
  end

  def author
    User.find_by_id(author_id)
  end

  def replies
    Reply.find_by_question_id(id)
  end

  def followers
    QuestionFollow.followers_for_question_id(id)
  end

  def likers
    QuestionLike.likers_for_question_id(id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(id)
  end


end
