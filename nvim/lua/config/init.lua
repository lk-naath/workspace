local path = vim.env.NVIM_CONFIG_PATH or vim.fn.stdpath("config") .. "/config.toml"
local file = assert(io.open(path, "r"), "Unable to open shared config: " .. path)
local contents = file:read("*a")
file:close()

-- This config uses TOML tables and string, boolean, and integer values only.
-- Keep the reader limited to that schema instead of starting another process
-- or adding a parser dependency to Neovim.
local data, section = {}, nil
for line in contents:gmatch("[^\r\n]+") do
	line = line:gsub("%s+#.*$", ""):gsub("^%s+", ""):gsub("%s+$", "")
	if line ~= "" and line:sub(1, 1) ~= "#" then
		local table_path = line:match("^%[([%w_%.%-]+)%]$")
		if table_path then
			section = data
			for key in table_path:gmatch("[^%.]+") do
				section[key] = section[key] or {}
				section = section[key]
			end
		else
			local key, raw = line:match("^([%w_%-]+)%s*=%s*(.-)%s*$")
			assert(key, "Invalid TOML config line: " .. line)
			local value
			if raw:match('^".*"$') then
				value = raw:sub(2, -2)
			elseif raw == "true" then
				value = true
			elseif raw == "false" then
				value = false
			else
				value = assert(tonumber(raw), "Invalid TOML config value: " .. raw)
			end
			(section or data)[key] = value
		end
	end
end

return data
