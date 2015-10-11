require 'byebug'

class Api::TodosController < ApplicationController
  def index
    @todos = Todo.all
    render json: @todos
  end

  def show
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      render json: @todo
    else
      render json: @todo.errors.full_messages
    end
  end

  def update
  end

  def destroy
    @todo = Todo.find(params[:id])
    render json: @todo if @todo.destroy
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :body)
  end
end
