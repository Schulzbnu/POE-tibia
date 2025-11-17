The Creature metatable contains all of the methods that handle/require creatures.  
This metatable is also <u>inherited</u> by the [Player](player.md), [Monster](monster.md) and [Npc](npc.md) metatables, therefore they can use these Creature methods.  

Creating an instance of the Creature metatable (2 options):
```Lua
local creature = Creature(uid)
local creature = Creature(name)
```
### Available methods:
[addCondition(condition, force = false)](#addCondition)  
[addHealth(healthChange)](#addHealth)  
[addMana(manaChange, animationOnLoss = false)](#addMana)  
[canSee(position)](#canSee)  
[canSeeCreature(creature)](#canSeeCreature)  
[changeSpeed(delta)](#changeSpeed)  
[getBaseSpeed()](#getBaseSpeed)  
[getCondition(conditionType, conditionId = CONDITIONID_COMBAT, subId = 0)](#getCondition)  
[getDamageMap()](#getDamageMap)  
[getDescription(distance)](#getDescription)  
[getDirection()](#getDirection)  
[getEvents()](#getEvents)  
[getFollowCreature()](#getFollowCreature)  
[getHealth()](#getHealth)  
[getId()](#getId)  
[getLight()](#getLight)  
[getMana()](#getMana)  
[getMaster()](#getMaster)  
[getMaxHealth()](#getMaxHealth)  
[getMaxMana()](#getMaxMana)  
[getName()](#getName)  
[getOutfit()](#getOutfit)  
[getParent()](#getParent)  
[getPathTo(pos, minTargetDist = 0, maxTargetDist = 1, fullPathSearch = true, clearSight = true, maxSearchDist = 0)](#getPathTo)  
[getPosition()](#getPosition)  
[getSkull()](#getSkull)  
[getSpeed()](#getSpeed)  
[getSummons()](#getSummons)  
[getTarget()](#getTarget)  
[getTile()](#getTile)  
[getZone()](#getZone)  
[isCreature()](#isCreature)  
[isHealthHidden()](#isHealthHidden)  
[isInGhostMode()](#isInGhostMode)  
[isItem()](#isItem)  
[isMonster()](#isMonster)  
[isMovementBlocked()](#isMovementBlocked)  
[isNpc()](#isNpc)  
[isPlayer()](#isPlayer)  
[isRemoved()](#isRemoved)  
[isTile()](#isTile)  
[registerEvent(name)](#registerEvent)  
[remove()](#remove)  
[removeCondition(conditionType, conditionId = CONDITIONID_COMBAT, subId = 0, force = false)](#removeCondition)  
[say(text, type, ghost = false, target = nil, position)](#say)  
[setDirection(direction)](#setDirection)  
[setDropLoot(doDrop)](#setDropLoot)  
[setFollowCreature(followedCreature)](#setFollowCreature)  
[setHealth(health)](#setHealth)  
[setHiddenHealth(hide)](#setHiddenHealth)  
[setLight(color, level)](#setLight)  
[setMaster(master)](#setMaster)  
[setMaxHealth(maxHealth)](#setMaxHealth)  
[setMovementBlocked(bool)](#setMovementBlocked)  
[setOutfit(outfit)](#setOutfit)  
[setSkull(skull)](#setSkull}) 
[setTarget(target)](#setTarget)  
[teleportTo(position, pushMovement = false)](#teleportTo)  
[unregisterEvent(name)](#unregisterEvent)  


***

<a name="addCondition"/>

##### addCondition(condition[, force = false])
> **Description:** N/A  
> **Parameters:** <ul><li>_condition_ - _No description_</li><li>_force_ - _(optional, default: false)_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:addCondition(some_userdata, false)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="addHealth"/>

##### addHealth(healthChange)
> **Description:** N/A  
> **Parameters:** <ul><li>_healthChange_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:addHealth(1)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="addMana"/>

##### addMana(manaChange[, animationOnLoss = false])
> **Description:** N/A  
> **Parameters:** <ul><li>_manaChange_ - _No description_</li><li>_animationOnLoss_ - _(optional, default: false)_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:addMana(1, false)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="canSee"/>

##### canSee(position)
> **Description:** N/A  
> **Parameters:** <ul><li>_position_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:canSee(Position())
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="canSeeCreature"/>

##### canSeeCreature(creature)
> **Description:** N/A  
> **Parameters:** <ul><li>_creature_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:canSeeCreature(some_userdata)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="changeSpeed"/>

##### changeSpeed(delta)
> **Description:** N/A  
> **Parameters:** <ul><li>_delta_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:changeSpeed(unknown)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getBaseSpeed"/>

##### getBaseSpeed()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:getBaseSpeed()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getCondition"/>

##### getCondition(conditionType[, conditionId = CONDITIONID_COMBAT[, subId = 0]])
> **Description:** N/A  
> **Parameters:** <ul><li>_conditionType_ - _No description_</li><li>_conditionId_ - _(optional, default: CONDITIONID_COMBAT)_</li><li>_subId_ - _(optional, default: 0)_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:getCondition(CONDITION_POISON, CONDITIONID_COMBAT, 0)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getDamageMap"/>

##### getDamageMap()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:getDamageMap()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getDescription"/>

##### getDescription(distance)
> **Description:** N/A  
> **Parameters:** <ul><li>_distance_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:getDescription(1)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getDirection"/>

##### getDirection()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:getDirection()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getEvents"/>

##### getEvents()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:getEvents()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.2

***

<a name="getFollowCreature"/>

##### getFollowCreature()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:getFollowCreature()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getHealth"/>

##### getHealth()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:getHealth()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getId"/>

##### getId()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:getId()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getLight"/>

##### getLight()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:getLight()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getMana"/>

##### getMana()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:getMana()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getMaster"/>

##### getMaster()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:getMaster()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getMaxHealth"/>

##### getMaxHealth()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:getMaxHealth()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getMaxMana"/>

##### getMaxMana()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:getMaxMana()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getName"/>

##### getName()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:getName()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getOutfit"/>

##### getOutfit()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:getOutfit()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getParent"/>

##### getParent()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:getParent()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getPathTo"/>

##### getPathTo(pos[, minTargetDist = 0[, maxTargetDist = 1[, fullPathSearch = true[, clearSight = true[, maxSearchDist = 0]]]]])
> **Description:** N/A  
> **Parameters:** <ul><li>_pos_ - _No description_</li><li>_minTargetDist_ - _(optional, default: 0)_</li><li>_maxTargetDist_ - _(optional, default: 1)_</li><li>_fullPathSearch_ - _(optional, default: true)_</li><li>_clearSight_ - _(optional, default: true)_</li><li>_maxSearchDist_ - _(optional, default: 0)_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:getPathTo(Position(), 0, 1, true, true, 0)
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
local creature = Creature(...)
creature:getPosition()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getSkull"/>

##### getSkull()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:getSkull()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0 for players, since 1.1 for any creature

***

<a name="getSpeed"/>

##### getSpeed()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:getSpeed()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getSummons"/>

##### getSummons()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:getSummons()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getTarget"/>

##### getTarget()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:getTarget()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getTile"/>

##### getTile()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:getTile()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getZone"/>

##### getZone()
> **Description:** Returns the zone (ZoneType_t) of a tile  
> **Parameters:** None  
> **Returns:** (enum) ZoneType_t  
> **Example:** 
```Lua
local creature = Creature(...)
creature:getZone()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.3

***

<a name="isCreature"/>

##### isCreature()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:isCreature()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="isHealthHidden"/>

##### isHealthHidden()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:isHealthHidden()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="isInGhostMode"/>

##### isInGhostMode()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:isInGhostMode()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="isItem"/>

##### isItem()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:isItem()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="isMonster"/>

##### isMonster()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:isMonster()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="isMovementBlocked"/>

##### isMovementBlocked()
> **Description:** Check if this creature can move or if it is blocked.  
> **Parameters:** None  
> **Returns:** bool (true/false)  
> **Example:** 
```Lua
local creature = Creature(...)
if not creature:isMovementBlocked() then
    creature::setMovementBlocked(true)
    print("Blocking " .. creature:getName() .. " from being able to move.")
end
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.3 [#2553](https://github.com/otland/forgottenserver/pull/2553)

***

<a name="isNpc"/>

##### isNpc()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:isNpc()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="isPlayer"/>

##### isPlayer()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:isPlayer()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="isRemoved"/>

##### isRemoved()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:isRemoved()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="isTile"/>

##### isTile()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** false  
> **Example:** 
```Lua
local creature = Creature(...)
creature:isTile()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.1

***

<a name="registerEvent"/>

##### registerEvent(name)
> **Description:** N/A  
> **Parameters:** <ul><li>_name_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:registerEvent(some_name)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="remove"/>

##### remove()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:remove()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="removeCondition"/>

##### removeCondition(conditionType[, conditionId = CONDITIONID_COMBAT[, subId = 0[, force = false]]])
> **Description:** N/A  
> **Parameters:** <ul><li>_conditionType_ - _No description_</li><li>_conditionId_ - _(optional, default: CONDITIONID_COMBAT)_</li><li>_subId_ - _(optional, default: 0)_</li><li>_force_ - _(optional, default: false)_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:removeCondition(CONDITION_POISON, CONDITIONID_COMBAT, 0, false)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="say"/>

##### say(text, type[, ghost = false[, target = nil[, position]]])
> **Description:** Test description  
> **Parameters:** <ul><li>_text_ - _Text shown to others._</li><li>_type_ - _Type of text that is shown._</li><li>_ghost_ - _(optional, default: false)_</li><li>_target_ - _(optional, default: nullptr)_</li><li>_position_ - _(optional)_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:say(any_string, TALKTYPE_SAY, false, nil, nil)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="setDirection"/>

##### setDirection(direction)
> **Description:** N/A  
> **Parameters:** <ul><li>_direction_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:setDirection(NORTH)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="setDropLoot"/>

##### setDropLoot(doDrop)
> **Description:** N/A  
> **Parameters:** <ul><li>_doDrop_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:setDropLoot(unknown)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="setFollowCreature"/>

##### setFollowCreature(followedCreature)
> **Description:** N/A  
> **Parameters:** <ul><li>_followedCreature_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:setFollowCreature(some_userdata)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="setHealth"/>

##### setHealth(health)
> **Description:** N/A  
> **Parameters:** <ul><li>_health_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:setHealth(185)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.3

***

<a name="setHiddenHealth"/>

##### setHiddenHealth(hide)
> **Description:** N/A  
> **Parameters:** <ul><li>_hide_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:setHiddenHealth(unknown)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="setLight"/>

##### setLight(color, level)
> **Description:** N/A  
> **Parameters:** <ul><li>_color_ - _No description_</li><li>_level_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:setLight(0xD7, LIGHT_LEVEL_DAY)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="setMaster"/>

##### setMaster(master)
> **Description:** N/A  
> **Parameters:** <ul><li>_master_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:setMaster(some_userdata)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="setMaxHealth"/>

##### setMaxHealth(maxHealth)
> **Description:** N/A  
> **Parameters:** <ul><li>_maxHealth_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:setMaxHealth(185)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="setMovementBlocked"/>

##### setMovementBlocked(bool)
> **Description:** Block or unblock a creature from being able to move  
> **Parameters:** <ul><li>_bool_ - _true/false - Block or unblock player_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
if creature:isMovementBlocked() then
    creature::setMovementBlocked(false)
    print("Allowing " .. creature:getName() .. " to move again.")
end
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.3 [#2553](https://github.com/otland/forgottenserver/pull/2553)

***

<a name="setOutfit"/>

##### setOutfit(outfit)
> **Description:** N/A  
> **Parameters:** <ul><li>_outfit_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:setOutfit(unknown)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="setSkull"/>

##### setSkull(skull)
> **Description:** N/A  
> **Parameters:** <ul><li>_skull_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:setSkull(SKULL_RED)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0 for players, since 1.1 for any creature

***

<a name="setTarget"/>

##### setTarget(target)
> **Description:** N/A  
> **Parameters:** <ul><li>_target_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:setTarget(some_userdata)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="teleportTo"/>

##### teleportTo(position[, pushMovement = false])
> **Description:** N/A  
> **Parameters:** <ul><li>_position_ - _No description_</li><li>_pushMovement_ - _(optional, default: false)_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:teleportTo(Position(), false)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="unregisterEvent"/>

##### unregisterEvent(name)
> **Description:** N/A  
> **Parameters:** <ul><li>_name_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local creature = Creature(...)
creature:unregisterEvent(some_name)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0