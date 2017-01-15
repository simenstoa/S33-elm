require('./styles.css');

require('./index.html');

var Elm = require('./Main.elm');
var root  = document.getElementById('root');

Elm.Main.embed(root);