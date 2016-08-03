module.exports = {
  entry: './app/main.js',
  output: {
    path: __dirname,
    filename: './public/bundle.js'
  },
  resolve: {
    root: __dirname,
    alias: {},
    extensions: ['', '.js']
  },
  module: {
    loaders: [
      {
        loader: 'babel-loader',
        query: {
          presets: ['react', 'es2015']
        },
        test: /\.js$/,
        exclude: /(node_modules)/
      }
    ]
  }
};
