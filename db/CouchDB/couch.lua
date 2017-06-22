db = {}
local pbytes = clr.System.Text.Encoding.UTF8.GetBytes(database['username'] .. ":" .. database['password']);
local auth = clr.System.Convert.ToBase64String(j)

function db.getUser(identifier, callback)
	local qu = {selector = {["identifier"] = identifier}}
	PerformHttpRequest("http://" .. database['host'] .. ":" .. database['port']  .. "/" .. database['name'] .. "/_find", function(err, rText, headers)
		local t = json.decode(rText)

		if(t.docs[1])then
			callback(t.docs[1])
		else
			callback(false)
		end
	end, "POST", json.encode(qu), {["Content-Type"] = 'application/json', Authorization = "Basic " .. auth})
end

function db.updateUser(identifier, update, callback)
	db.getUser(identifier, function(user)
		for i in pairs(update)do
			user[i] = update[i]
		end

		PerformHttpRequest("http://" .. database['host'] .. ":" .. database['port'] .. "/" .. database['name'] .. "/" .. user._id, function(err, rText, headers)
			callback((err or true))
		end, "PUT", json.encode(user), {["Content-Type"] = 'application/json', Authorization = "Basic " .. auth})
	end)
end

TriggerEvent('es:exposeDBFunctions', function(DB)
	db.createDocument = DB.createDocument
	DB.createDatabase(database['name'], function()end)
end)