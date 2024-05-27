require "preamble"
-- import general functions
local plugins = require "plugins"

require("lazy").setup(plugins);

-- things that need to happen after all plugins have loaded
require "mappings"
require "settings"
