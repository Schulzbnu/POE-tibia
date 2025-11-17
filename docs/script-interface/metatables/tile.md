A tile is a map square in the server. It holds information such as tile type, house association, ground type, items and creatures. 

A [Position](https://github.com/otland/forgottenserver/wiki/Metatable:Position) object can be used to grab a specific tile in the server.
```lua
local tile = Tile(player:getPosition())
```

### Available methods:
[getBottomCreature()](#getBottomCreature)  
[getBottomVisibleCreature(creature)](#getBottomVisibleCreature)  
[getCreatureCount()](#getCreatureCount)  
[getCreatures()](#getCreatures)  
[getDownItemCount()](#getDownItemCount)  
[getFieldItem()](#getFieldItem)  
[getGround()](#getGround)  
[getHouse()](#getHouse)  
[getItemById(itemId, subType = -1)](#getItemById)  
[getItemByTopOrder(topOrder)](#getItemByTopOrder)  
[getItemByType(itemType)](#getItemByType)  
[getItemCount()](#getItemCount)  
[getItemCountById(itemId, subType = -1)](#getItemCountById)  
[getItems()](#getItems)  
[getPosition()](#getPosition)  
[getThing(index)](#getThing)  
[getThingCount()](#getThingCount)  
[getThingIndex(thing)](#getThingIndex)  
[getTopCreature()](#getTopCreature)  
[getTopDownItem()](#getTopDownItem)  
[getTopItemCount()](#getTopItemCount)  
[getTopTopItem()](#getTopTopItem)  
[getTopVisibleCreature(creature)](#getTopVisibleCreature)  
[getTopVisibleThing(creature)](#getTopVisibleThing)  
[hasFlag(flag)](#hasFlag)  
[hasProperty(property, item)](#hasProperty)  
[isCreature()](#isCreature)  
[isItem()](#isItem)  
[isTile()](#isTile)  
[queryAdd(thing, flags)](#queryAdd)  
[remove()](#remove)  


***

<a name="getBottomCreature"/>

##### getBottomCreature()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local tile = Tile(...)
tile:getBottomCreature()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getBottomVisibleCreature"/>

##### getBottomVisibleCreature(creature)
> **Description:** N/A  
> **Parameters:** <ul><li>_creature_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local tile = Tile(...)
tile:getBottomVisibleCreature(some_userdata)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getCreatureCount"/>

##### getCreatureCount()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local tile = Tile(...)
tile:getCreatureCount()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getCreatures"/>

##### getCreatures()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local tile = Tile(...)
tile:getCreatures()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getDownItemCount"/>

##### getDownItemCount()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local tile = Tile(...)
tile:getDownItemCount()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getFieldItem"/>

##### getFieldItem()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local tile = Tile(...)
tile:getFieldItem()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getGround"/>

##### getGround()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local tile = Tile(...)
tile:getGround()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getHouse"/>

##### getHouse()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local tile = Tile(...)
tile:getHouse()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getItemById"/>

##### getItemById(itemId[, subType = -1])
> **Description:** N/A  
> **Parameters:** <ul><li>_itemId_ - _No description_</li><li>_subType_ - _(optional, default: -1)_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local tile = Tile(...)
tile:getItemById(2400, -1)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getItemByTopOrder"/>

##### getItemByTopOrder(topOrder)
> **Description:** N/A  
> **Parameters:** <ul><li>_topOrder_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local tile = Tile(...)
tile:getItemByTopOrder(unknown)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getItemByType"/>

##### getItemByType(itemType)
> **Description:** N/A  
> **Parameters:** <ul><li>_itemType_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local tile = Tile(...)
tile:getItemByType(ITEM_TYPE_TELEPORT)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getItemCount"/>

##### getItemCount()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local tile = Tile(...)
tile:getItemCount()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getItemCountById"/>

##### getItemCountById(itemId[, subType = -1])
> **Description:** N/A  
> **Parameters:** <ul><li>_itemId_ - _No description_</li><li>_subType_ - _(optional, default: -1)_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local tile = Tile(...)
tile:getItemCountById(2400, -1)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getItems"/>

##### getItems()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local tile = Tile(...)
tile:getItems()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getPosition"/>

##### getPosition()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local tile = Tile(...)
tile:getPosition()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getThing"/>

##### getThing(index)
> **Description:** N/A  
> **Parameters:** <ul><li>_index_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local tile = Tile(...)
tile:getThing(some_id)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getThingCount"/>

##### getThingCount()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local tile = Tile(...)
tile:getThingCount()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getThingIndex"/>

##### getThingIndex(thing)
> **Description:** N/A  
> **Parameters:** <ul><li>_thing_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local tile = Tile(...)
tile:getThingIndex(userdata_or_id)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getTopCreature"/>

##### getTopCreature()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local tile = Tile(...)
tile:getTopCreature()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getTopDownItem"/>

##### getTopDownItem()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local tile = Tile(...)
tile:getTopDownItem()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getTopItemCount"/>

##### getTopItemCount()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local tile = Tile(...)
tile:getTopItemCount()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getTopTopItem"/>

##### getTopTopItem()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local tile = Tile(...)
tile:getTopTopItem()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getTopVisibleCreature"/>

##### getTopVisibleCreature(creature)
> **Description:** N/A  
> **Parameters:** <ul><li>_creature_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local tile = Tile(...)
tile:getTopVisibleCreature(some_userdata)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getTopVisibleThing"/>

##### getTopVisibleThing(creature)
> **Description:** N/A  
> **Parameters:** <ul><li>_creature_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local tile = Tile(...)
tile:getTopVisibleThing(some_userdata)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="hasFlag"/>

##### hasFlag(flag)
> **Description:** N/A  
> **Parameters:** <ul><li>_flag_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local tile = Tile(...)
tile:hasFlag(unknown)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="hasProperty"/>

##### hasProperty(property[, item])
> **Description:** N/A  
> **Parameters:** <ul><li>_property_ - _No description_</li><li>_item_ - _(optional)_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local tile = Tile(...)
tile:hasProperty(unknown, nil)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="isCreature"/>

##### isCreature()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** false  
> **Example:** 
```Lua
local tile = Tile(...)
tile:isCreature()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.1

***

<a name="isItem"/>

##### isItem()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** false  
> **Example:** 
```Lua
local tile = Tile(...)
tile:isItem()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.1

***

<a name="isTile"/>

##### isTile()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** true  
> **Example:** 
```Lua
local tile = Tile(...)
tile:isTile()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.1

***

<a name="queryAdd"/>

##### queryAdd(thing[, flags])
> **Description:** N/A  
> **Parameters:** <ul><li>_thing_ - _No description_</li><li>_flags_ - _(optional)_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local tile = Tile(...)
tile:queryAdd(userdata_or_id, nil)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="remove"/>

##### remove()
> **Description:** Remove a tile, ground, items and creatures in that tile. (Except players, which are being teleported to temple position)  
> **Parameters:** None  
> **Returns:** nil if tile doesn't exist, otherwise true.   
> **Example:** 
```Lua
local tile = Tile(...)
tile:remove()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.4 #2952