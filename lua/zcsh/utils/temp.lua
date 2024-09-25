local s = [[
person:
	name: zsh
	age: 18
]]
local yaml = require('lyaml')
local yaml_data = yaml.load(s)
print(yaml_data)
