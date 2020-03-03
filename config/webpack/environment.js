const { environment } = require('@rails/webpacker')
const webpack = require("webpack")

environment.plugins.append("Provide",new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery :'jquery',
  Popper: ['Popper.js','default']
}))  

module.exports = environment

environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery'
  })
)

module.exports = environment
