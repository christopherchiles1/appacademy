/* global React */
(function(root) {
  'use strict';

  if (typeof root.Components === "undefined") {
    root.Components = {};
  }
  var Components = root.Components;
  var TodoStore = root.TodoStore;

  var TodoForm = Components.TodoForm = React.createClass({
    getInitialState: function () {
      return {title: "", body: ""};
    },
    handleTitleInput: function (e) {
      this.setState({title: e.target.value});
    },
    handleBodyInput: function (e) {
      this.setState({body: e.target.value});
    },
    handleSubmit: function (e) {
      e.preventDefault();
      this.props.createTodo({todo: this.state});
    },
    render: function () {
      return (
        <form onSubmit={this.handleSubmit}>
          <input type="text" value={this.state.title} onChange={this.handleTitleInput} placeholder="Title"/>
          <textarea value={this.state.body} onChange={this.handleBodyInput} placeholder="Body"></textarea>
          <input type="submit" value="Add Todo"/>
        </form>
      );
    }
  });
}(this));
