--- Checks if an FTP server allows anonymous logins.
-- @output
-- |_ Anonymous FTP: Anonymous login allowed"

id="Anonymous FTP"
description="Checks to see if a FTP server allows anonymous logins"
author = "Eddie Bell <ejlbell@gmail.com>"
license = "Same as Nmap--See http://nmap.org/book/man-legal.html"
categories = {"default", "auth", "intrusive"}

require "shortport"

---
-- Works on port 21 or "ftp"
portrule = shortport.port_or_service(21, "ftp")

---
-- Connects to the ftp server and checks if the server allows
-- anonymous logins.
action = function(host, port)
	local socket = nmap.new_socket()
	local result
	local status = true
	local isAnon = false

	local err_catch = function()
		socket:close()
	end

	local try = nmap.new_try(err_catch())

	socket:set_timeout(5000)
	try(socket:connect(host.ip, port.number, port.protocol))
	try(socket:send("USER anonymous\r\n"))
	try(socket:send("PASS IEUser@\r\n"))

        while status do
		status, result = socket:receive_lines(1);
		if string.match(result, "^230") then
			isAnon = true
			break
		end
	end

	socket:close()

	if(isAnon) then
		return "FTP: Anonymous login allowed"
	end
end
