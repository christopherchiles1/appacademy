/* global React */
(function (root) {
  'use strict';

  if (typeof root.Components === "undefined") {
    root.Components = {};
  }
  var Components = root.Components;
  var TodoStore = root.TodoStore;

  var TodoList = Components.TodoList = React.createClass({
    getInitialState: function () {
      return {store: TodoStore.all()};
    },
    todosChanged: function () {
      this.setState({store: TodoStore.all()});
    },
    componentDidMount: function () {
      TodoStore.addChangedHandler(this.todosChanged);
      TodoStore.fetch();
    },
    componentWillUnmount: function () {
      TodoStore.removeChangedHandler(this.todosChanged);
    },
    addTodo: function (todo) {
      TodoStore.create(todo);
    },
    destroyTodo: function (id) {
      TodoStore.destroy(id);
    },
    render: function () {
      return (
        <div>
          <Components.TodoForm createTodo={this.addTodo}/>
          {
            this.state.store.map(function (todo) {
              return (
                <Components.TodoListItem
                  key={todo.id}
                  deleteTodo={this.destroyTodo}
                  todo={todo} />
              );
            }.bind(this))
          }
        </div>
      );
    }
  });

}(this));
