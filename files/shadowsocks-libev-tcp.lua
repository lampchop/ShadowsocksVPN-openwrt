local fs = require "nixio.fs"
local conffile = "/etc/shadowsocks/tcp.json" 

f = SimpleForm("TCP翻墙", translate("Shadowsocks - TCP翻墙"), translate("设置TCP的翻墙，可以在这里设置走kcptun的连接加速"))

t = f:field(TextValue, "conf")
t.rmempty = true
t.rows = 10
function t.cfgvalue()
	return fs.readfile(conffile) or ""
end

function f.handle(self, state, data)
	if state == FORM_VALID then
		if data.conf then
			fs.writefile(conffile, data.conf:gsub("\r\n", "\n"))
			luci.sys.call("/etc/init.d/shadowsocks restart")
		end
	end
	return true
end

return f
