No description available at the moment.
### Available methods:
[getDistance(positionEx)](#getDistance)  
[isSightClear(positionEx[, sameFloor = true])](#isSightClear)  
[isInRange(from, to)](#isInRange)  
[sendDistanceEffect(positionEx, distanceEffect, player = nil)](#sendDistanceEffect)  
[sendMagicEffect(magicEffect[, player = nil])](#sendMagicEffect)  


***

<a name="getDistance"/>

##### getDistance(positionEx)
> **Description:** N/A  
> **Parameters:** <ul><li>_positionEx_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local position = Position(...)
position:getDistance(Position())
```
> **Added in version:** 1.0

***

<a name="isSightClear"/>

##### isSightClear(positionEx[, sameFloor = true])
> **Description:** N/A  
> **Parameters:** <ul><li>_positionEx_ - _No description_</li><li>_sameFloor_ - _(optional, default: true)_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local position = Position(...)
position:isSightClear(Position(), true)
```
> **Added in version:** 1.0

***

<a name="isInRange"/>

##### isInRange(from, to)
> **Description:** Checks if current position is inside the specified range from and to.  
> **Parameters:** <ul><li>_from_ - _Position object or table_</li><li>_to_ - _Position object or table_</li></ul>
> **Returns:** Boolean: true/false  
> **Example:** 
```Lua
-- Sample #1:
local position = Position(...)
if position:isInRange({x=100, y=100, z=6}, {x=200, y=200, z=8}) then
    -- Position is inside
end

-- Sample #2:
local zone = {
    from = Position(100, 100, 6),
    to = Position(200, 200, 8)
}

local playerpos = player:getPosition()
if playerpos:isInRange(zone.from, zone.to) then
    -- Player is in the zone
end
```
> **Added in version:** 1.3

***

<a name="sendDistanceEffect"/>

##### sendDistanceEffect(positionEx, distanceEffect[, player = nil])
> **Description:** N/A  
> **Parameters:** <ul><li>_positionEx_ - _Other Position object or table_</li><li>_[distanceEffect](Constants#ShootType)_</li><li>_player_ - _(optional, default: nil)_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local position = Position(...)
position:sendDistanceEffect(Position(), CONST_ANI_ARROW, nil)
```
> **Added in version:** 1.0

***

<a name="sendMagicEffect"/>

##### sendMagicEffect(magicEffect[, player = nil])
> **Description:** N/A  
> **Parameters:** <ul><li>_[MagicEffect](Constants#MagicEffect)_</li><li>_player_ - _(optional, default: nil)_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local position = Position(...)
position:sendMagicEffect(CONST_ME_POFF, nil)
```
> **Added in version:** 1.0