/* global React */
(function (root) {
  'use strict';

  if (typeof root.Components === "undefined") {
    root.Components = {};
  }
  var Components = root.Components;
  var TodoStore = root.TodoStore;

  var TodoListItem = Components.TodoListItem = React.createClass({
    handleClick: function (e) {
      e.preventDefault();
      this.props.deleteTodo(this.props.todo.id);
    },
    render: function () {
      return (
        <div>
          <div>{this.props.todo.title}</div>
          <div>{this.props.todo.body}</div>
          <button onClick={this.handleClick}>Delete</button>
        </div>
      );
    }
  });
}(this));
