/* global React */

 if ( typeof AutoCompleteWidget === "undefined" ) {
    window.AutoCompleteWidget = {};
  }
var AutoComplete = React.createClass({
  getInitialState: function () {
    return {
      query: "",
      matches: []
    };
  },
  handleInput: function (e) {
    this.setState({query: e.target.value});
  },
  clickedName: function (e) {
    this.setState({ query: e.currentTarget.textContent });
  },
  render: function () {
    var users = this.props.users,
        queryString = this.state.query.trim().toLowerCase();
    var matches = users.filter(function (user) {
      return user.name.toLowerCase().match(queryString);
    });
    return (
      <div className="autocomplete">
        <label>
          Find Someone!
          <input
            type="text"
            onChange={this.handleInput}
            value={this.state.query}
            placeholder="Enter a name here"/>
        </label>
        <ul>
        {
          matches.map(function (match) {
            return <li><a onClick={this.clickedName}>{match.name}</a></li>;
          }.bind(this))
        }
        </ul>
      </div>
    );
  }
});

// seed data
var library = [
  { name: "Allison" },
  { name: "Alice" },
  { name: "Marvin" },
  { name: "Chris" },
  { name: "Evan" },
  { name: "Elvis" },
  { name: "Christopher" },
];

React.render(
  <AutoComplete users={ library }/>,
  document.getElementById('autocomplete')
);
