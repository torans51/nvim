local settings = require('settings')
local mappings = require('mappings')
local plugins = require('plugins')
local plugins_conf = require('plugins-conf')

settings.load()
mappings.load()
plugins.load()
plugins_conf.load()

