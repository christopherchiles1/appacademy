(function () {
  if ( typeof window.TabWidget === "undefined" ) {
    window.TabWidget = {};
  }

  var React = window.React;

  var Tabs = window.TabWidget.Tabs =
  React.createClass({
    getInitialState: function () {
      return {activeIndex: 0};
    },
    handleClick: function (idx, e) {
      this.setState({activeIndex: idx});
    },
    render: function () {
      return (
        <div className="tabs-container">
          <ul>
          {
            this.props.dogs.map(function (dog, idx) {
              return (
                <Header
                  handleClick={this.handleClick.bind(this, idx)}
                  active={idx === this.state.activeIndex}
                  title={dog.title} />
              );
            }.bind(this))
          }
          </ul>

         <div className="tab-content">
           <p>
             {this.props.dogs[this.state.activeIndex].content}
           </p>
         </div>
      </div>

      );
    }
  });

  var Header = window.TabWidget.Header = React.createClass({

    render: function() {
      var boldStyle = {fontWeight: 'bold',
                       color: 'blue'};
      if (this.props.active === true) {
        return <li onClick={this.props.handleClick}
                   style={boldStyle}>{this.props.title}
               </li>;
      } else {
        return <li onClick={this.props.handleClick}>{this.props.title}</li>;
      }
    }
  });

  //seeds
  var Dogs = [
    {title: 'Husky', content: 'Siberian Huskies are strong, compact, working sled dogs. The medium-sized head is in proportion to the body, with a muzzle that is equal in length to the skull, with a well-defined stop.'},
    {title: 'Doberman', content: 'The Doberman Pinscher is a medium sized, squarely built dog with a compact, muscular body. The head is long and when viewed from the side, looks like a blunt wedge.'},
    {title: 'Dalmation', content: 'The Dalmatian is a large, strong, muscular dog. The skull is about as wide as it is long, and flat on the top. The muzzle is about the same length as the top of the skull.'},
    {title: 'German Shepard', content: 'The German Shepherd Dog is well proportioned and very strong. The GSD has a sturdy, muscular, slightly elongated body with a light, solid bone structure.'}
  ];

  React.render(
    <Tabs dogs={Dogs}/>,
    document.getElementById('tabs-widget')
  );
})();
