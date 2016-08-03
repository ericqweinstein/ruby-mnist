MNIST Ruby Demo
===============

## About
The MNIST Ruby demo is a Ruby application I built for a talk presented at the [RubyConf 2016](http://rubyconf.org/program#prop_58) that classifies handwritten digits based on the [MNIST dataset](http://yann.lecun.com/exdb/mnist/). Much is owed to [Geoff Buesing](https://github.com/gbuesing/mnist-ruby-test), whose work I encountered during my research.

The front end is written using [React](https://facebook.github.io/react/) + ES6, which is _super_ overkill, but was fun to do.

## Running Locally
You'll need the following to run this project:

* [NPM](https://www.npmjs.com/) (3+)
* [Node](https://nodejs.org) (4+)
* [Ruby](https://www.ruby-lang.org/en/) (2.2+)
* [Webpack](https://webpack.github.io/)

Install dependencies:

```sh
λ git clone https://github.com/ericqweinstein/ruby-mnist
λ npm i && npm i -g webpack
λ bundle
```

Build:

```sh
λ webpack
```

Start:

```
λ ruby server.rb
```

The application already has the MNIST data in `data/` and has been pre-trained, so you can start it immediately. If you'd like to do the training yourself:

```sh
λ ruby lib/neural_net.rb
```

You can see the application live [here](http://ruby-mnist.herokuapp.com/).

## Contributing
1. Branch (`λ git checkout -b fancy-new-feature`)
2. Commit (`λ git commit -m "Fanciness!"`)
3. Push (`λ git push origin fancy-new-feature`)
4. Ye Olde Pulle Request

## License
MIT (see LICENSE).
