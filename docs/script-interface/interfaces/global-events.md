Global stuff... (TODO)
```Lua
-- Empty!
```
### Available events:
[onRecord()](#onRecord)  
[onShutdown()](#onShutdown)  
[onStartup()](#onStartup)  
[onTime()](#onTime)  


***

<a name="onRecord"/>

##### onRecord()
> **Description:** Execute Lua code when a new concurrent players online record occurs.  
> **Parameters:** current, old  
> **Accepted return values:** boolean (true/false)  
> **Example:** 
```Lua
function onRecord(current, old)
	addEvent(broadcastMessage, 150, "New record: " .. current .. " players are logged in.", MESSAGE_STATUS_DEFAULT)
	return true
end
```
Added in version: 1.0

***

<a name="onShutdown"/>

##### onShutdown()
> **Description:** Execute Lua code just before the server shuts down. Note: May not execute if server crashes.
> **Parameters:** N/A  
> **Accepted return values:** N/A  
> **Example:** 
```Lua
N/A  
```
Added in version: 1.0

***

<a name="onStartup"/>

##### onStartup()
> **Description:** N/A  
> **Parameters:** N/A  
> **Accepted return values:** N/A  
> **Example:** 
```Lua
function onStartup()
	math.randomseed(os.mtime())
	-- store towns in database
	db.query("TRUNCATE TABLE `towns`")
	for i, town in ipairs(Game.getTowns()) do
		local position = town:getTemplePosition()
		db.query("INSERT INTO `towns` (`id`, `name`, `posx`, `posy`, `posz`) VALUES (" .. town:getId() .. ", " .. db.escapeString(town:getName()) .. ", " .. position.x .. ", " .. position.y .. ", " .. position.z .. ")")
	end
end
```
Added in version: 1.0

***

<a name="onTime"/>

##### onTime()
> **Description:** N/A  
> **Parameters:** N/A  
> **Accepted return values:** N/A  
> **Example:** 
```Lua
N/A  
```
Added in version: 1.0