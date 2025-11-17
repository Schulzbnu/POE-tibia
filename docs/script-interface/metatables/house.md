No description available at the moment.
### Available methods:
[getAccessList(listId)](#getAccessList)  
[getBedCount()](#getBedCount)  
[getBeds()](#getBeds)  
[getDoorCount()](#getDoorCount)  
[getDoors()](#getDoors)  
[getExitPosition()](#getExitPosition)  
[getId()](#getId)  
[getItems()](#getItems)  
[getName()](#getName)  
[getOwnerGuid()](#getOwnerGuid)  
[getOwnerGuild()](#getOwnerGuild)  
[getRent()](#getRent)  
[getTileCount()](#getTileCount)  
[getTiles()](#getTiles)  
[getTown()](#getTown)  
[getType()](#getType)  
[setAccessList(listId, list)](#setAccessList)  
[setOwnerGuid(guid, updateDatabase = true)](#setOwnerGuid)  


***

<a name="getAccessList"/>

##### getAccessList(listId)
> **Description:** N/A  
> **Parameters:** <ul><li>_listId_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local house = House(...)
house:getAccessList(GUEST_LIST)
```
> **Added in version:** 1.0

***

<a name="getBedCount"/>

##### getBedCount()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local house = House(...)
house:getBedCount()
```
> **Added in version:** 1.0

***

<a name="getBeds"/>

##### getBeds()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local house = House(...)
house:getBeds()
```
> **Added in version:** 1.0

***

<a name="getDoorCount"/>

##### getDoorCount()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local house = House(...)
house:getDoorCount()
```
> **Added in version:** 1.0

***

<a name="getDoors"/>

##### getDoors()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local house = House(...)
house:getDoors()
```
> **Added in version:** 1.0

***

<a name="getExitPosition"/>

##### getExitPosition()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local house = House(...)
house:getExitPosition()
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
local house = House(...)
house:getId()
```
> **Added in version:** 1.0

***

getItems

<a name="getItems"/>

##### getItems()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** a table with the items that are in that house
> **Example:** 
```Lua
local house = House(...)
house:getItems()
```
> **Added in version:** 1.3

***

<a name="getName"/>

##### getName()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local house = House(...)
house:getName()
```
> **Added in version:** 1.0

***

<a name="getOwnerGuid"/>

##### getOwnerGuid()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local house = House(...)
house:getOwnerGuid()
```
> **Added in version:** 1.0

***

<a name="getOwnerGuild"/>

##### getOwnerGuild()
> **Description:** Return the guild_id of the house if it is a guildhall  
> **Parameters:** None  
> **Returns:** guild_id  
> **Example:** 
```Lua
local house = House(...)
if house:getType() == HOUSE_TYPE_GUILDHALL then
    house:getOwnerGuild()
end
```
> **Added in version:** 1.4 [#2214](https://github.com/otland/forgottenserver/pull/2214)

***

<a name="getRent"/>

##### getRent()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local house = House(...)
house:getRent()
```
> **Added in version:** 1.0

***

<a name="getTileCount"/>

##### getTileCount()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local house = House(...)
house:getTileCount()
```
> **Added in version:** 1.0

***

<a name="getTiles"/>

##### getTiles()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local house = House(...)
house:getTiles()
```
> **Added in version:** 1.0

***

<a name="getTown"/>

##### getTown()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local house = House(...)
house:getTown()
```
> **Added in version:** 1.0

***

<a name="getType"/>

##### getType()
> **Description:** Retrieve house type.  
> **Parameters:** None   
> **Returns:** Enum HouseType (HOUSE_TYPE_NORMAL, HOUSE_TYPE_GUILDHALL)   
> **Example:** 
```Lua
local house = House(...)
if house:getType() == HOUSE_TYPE_GUILDHALL then
    -- ...
end
```
> **Added in version:** 1.4 [#2214](https://github.com/otland/forgottenserver/pull/2214)

***

<a name="setAccessList"/>

##### setAccessList(listId, list)
> **Description:** N/A  
> **Parameters:** <ul><li>_listId_ - _No description_</li><li>_list_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local house = House(...)
house:setAccessList(GUEST_LIST, house_name_list)
```
> **Added in version:** 1.0

***

<a name="setOwnerGuid"/>

##### setOwnerGuid(guid[, updateDatabase = true])
> **Description:** N/A  
> **Parameters:** <ul><li>_guid_ - _No description_</li><li>_updateDatabase_ - _(optional, default: true)_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local house = House(...)
house:setOwnerGuid(unknown, true)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0