No description available at the moment.
### Available methods:
[addMember(player)](#addMember)  
[addRank(id, name, level)](#addRank)  
[getId()](#getId)  
[getMembersOnline()](#getMembersOnline)  
[getMotd()](#getMotd)  
[getName()](#getName)  
[getRankById(id)](#getRankById)  
[getRankByLevel(level)](#getRankByLevel)  
[removeMember(player)](#removeMember)  
[setMotd(motd)](#setMotd)  
[getBankBalance()](#getBankBalance)  
[setBankBalance()](#setBankBalance)  
[getOwnerGUID()](#getOwnerGUID)  

***

<a name="addMember"/>

##### addMember(player)
> **Description:** N/A  
> **Parameters:** <ul><li>_player_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local guild = Guild(...)
guild:addMember(some_userdata)
```
> **Added in version:** 1.0

***

<a name="addRank"/>

##### addRank(id, name, level)
> **Description:** N/A  
> **Parameters:** <ul><li>_id_ - _No description_</li><li>_name_ - _No description_</li><li>_level_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local guild = Guild(...)
guild:addRank(some_id, some_name, 1)
```
> **Added in version:** 1.0

***

<a name="getId"/>

##### getId()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local guild = Guild(...)
guild:getId()
```
> **Added in version:** 1.0

***

<a name="getMembersOnline"/>

##### getMembersOnline()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local guild = Guild(...)
guild:getMembersOnline()
```
> **Added in version:** 1.0

***

<a name="getMotd"/>

##### getMotd()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local guild = Guild(...)
guild:getMotd()
```
> **Added in version:** 1.0

***

<a name="getName"/>

##### getName()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local guild = Guild(...)
guild:getName()
```
> **Added in version:** 1.0

***

<a name="getRankById"/>

##### getRankById(id)
> **Description:** N/A  
> **Parameters:** <ul><li>_id_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local guild = Guild(...)
guild:getRankById(some_id)
```
> **Added in version:** 1.0

***

<a name="getRankByLevel"/>

##### getRankByLevel(level)
> **Description:** N/A  
> **Parameters:** <ul><li>_level_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local guild = Guild(...)
guild:getRankByLevel(1)
```
> **Added in version:** 1.0

***

<a name="removeMember"/>

##### removeMember(player)
> **Description:** N/A  
> **Parameters:** <ul><li>_player_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local guild = Guild(...)
guild:removeMember(some_userdata)
```
> **Added in version:** 1.0

***

<a name="setMotd"/>

##### setMotd(motd)
> **Description:** N/A  
> **Parameters:** <ul><li>_motd_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local guild = Guild(...)
guild:setMotd(any_string)
```
> **Added in version:** 1.0

***

<a name="getBankBalance"/>

##### getBankBalance()
> **Description:** Get bank balance (gold coins stored up in the guild).  
> **Parameters:** None   
> **Returns:** int - balance   
> **Example:** 
```Lua
local guild = Guild(...)
guild:getBankBalance()
```
> **Added in version:** 1.4 [#2214](https://github.com/otland/forgottenserver/pull/2214)

***

<a name="setBankBalance"/>

##### setBankBalance(newBalance)
> **Description:** Set bank balance.  
> **Parameters:** (Number) new bank balance   
> **Returns:** bool true or nil   
> **Example:** 
```Lua
local guild = Guild(...)
local rent = 2000
guild:setBankBalance(guild:getBankBalance() - rent)
```
> **Added in version:** 1.4 [#2214](https://github.com/otland/forgottenserver/pull/2214)

***

<a name="getOwnerGUID"/>

##### getOwnerGUID()
> **Description:** Get the player GUID number that is the guild leader of this guild.  
> **Parameters:** None   
> **Returns:** int - player:guid   
> **Example:** 
```Lua
local player = Player(...)
local guild = player:getGuild()
if guild and player:getGUID() == guild:getOwnerGUID() then
    print("Player: " .. player:getName() .. " is the Guild Leader of: " .. guild:getName())
end
```
> **Added in version:** 1.4 [#2214](https://github.com/otland/forgottenserver/pull/2214)