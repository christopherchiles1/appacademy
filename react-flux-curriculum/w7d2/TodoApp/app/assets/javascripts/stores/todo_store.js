(function(root) {
  'use strict';

  var _todos = [];
  var _callbacks = [];

  var TodoStore = root.TodoStore = {
    all: function () {
      return _todos;
    },
    fetch: function () {
      $.ajax({
        url: '/api/todos',
        type: 'GET',
        dataType: 'json',
        success: function (todos) {
          _todos = todos;
          TodoStore.changed();
        }
      });
    },
    create: function (todo) {
      $.ajax({
        url: '/api/todos',
        type: 'POST',
        dataType: 'json',
        data: todo,
        success: function (todo) {
          _todos.push(todo);
          TodoStore.changed();
        }
      });
    },
    destroy: function (id) {
      $.ajax({
        url: '/api/todos/' + id,
        type: 'DELETE',
        dataType: 'json',
        success: function () {
          debugger;
          var idx = _todos.indexOf(TodoStore.find(id));
          _todos.splice(idx, 1);
          TodoStore.changed();
        }
      });
    },
    toggleDone: function(id) {
      var todo = TodoStore.find(id);
      todo.done = !todo.done;
      $.ajax({
        url: '/api/todos/' + id,
        type: 'PATCH',
        data: todo,
        dataType: 'json',
        success: function () {
          TodoStore.changed();
        }
      });
    },
    find: function(id) {
      //DOESN'T WORK
      _todos.forEach(function (todo) {
        if (todo.id === id) {
          return todo;
        }
      });
    },
    changed: function () {
      _callbacks.forEach(function (callback) {
        callback();
      });
    },
    addChangedHandler: function (handler) {
      _callbacks.push(handler);
    },
    removeChangedHandler: function (handler) {
      var idx = _callbacks.indexOf(handler);
      _callbacks.splice(idx, 1);
    }
  };

}(this));
