require "webpacker/configuration"

say "Copying coffee loader to config/webpack/loaders"
copy_file "#{__dir__}/loaders/coffee.js", Rails.root.join("config/webpack/loaders/coffee.js").to_s

say "Adding coffee loader to config/webpack/environment.js"
insert_into_file Rails.root.join("config/webpack/environment.js").to_s,
  "const coffee =  require('./loaders/coffee')\n",
  after: "const { environment } = require('@rails/webpacker')\n"

insert_into_file Rails.root.join("config/webpack/environment.js").to_s,
  "environment.loaders.append('coffee', coffee)\n",
  before: "module.exports"

say "Copying the example entry file to #{Webpacker.config.source_entry_path}"
copy_file "#{__dir__}/examples/coffee/hello_coffee.coffee",
  "#{Webpacker.config.source_entry_path}/hello_coffee.coffee"

say "Installing all Coffeescript dependencies"
run "yarn add coffeescript@1.12.7 coffee-loader"

say "Webpacker now supports Coffeeescript 🎉", :green