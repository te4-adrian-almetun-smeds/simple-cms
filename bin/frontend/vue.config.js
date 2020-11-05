module.exports = {
  configureWebpack: {
    rules: [
      {
        test: /\.(png|ico)$/,
        exclude: [
          path.resolve(__dirname, 'node_modules')
        ]
      }
    ]
  }
};

