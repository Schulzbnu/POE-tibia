Revscriptsys is a new alternative way to register scripts so that you don't need to do it via XML. You just need to place your lua scripts inside `data/scripts/`, or any subfolder of it if you want. Monster scripts are, however, placed in a different path: `data/monster/` (or any subfolder of it, like before).
This system supports the usage of different metatables in the same script (Actions, MoveEvents, GlobalEvents...). This comes in hand if you do prolonged quests (for example), which otherwise would need separate files for each metatable.
The script must contain a `header` and `footer`, as shown in the following example.

Action `onUse` example:
```lua
local testAction = Action() -- this is our header, the first thing we have to write (except for configuration tables and such)

function testAction.onUse(player, item, fromPosition, target, toPosition, isHotkey) -- now we can design the action itself
	return print("We used this item: " .. item.itemid)
end

testAction:id(2550) -- the item is a scythe
testAction:register() -- this is our footer, it has to be the last function executed
```

### Available metatables:

[Action()](#action)

[CreatureEvent("name")](#creatureevent)

[GlobalEvent("name")](#globalevent)

[MonsterType("name")](#monstertype)

[MoveEvent()](#moveevent)

[Spell("name")](#spell)

[TalkAction("words")](#talkaction)

[Weapon(WEAPON_TYPE)](#weapon)

***

<a name="action"/>

#### Action()
> **Interfaces:** <ul><li>onUse</li></ul>
> **Methods:** <ul><li>[id(ids)](#actionid)</li><li>[aid(ids)](#actionaid)</li><li>[uid(ids)](#actionuid)</li><li>[allowFarUse(bool)](#actionallowfaruse)</li><li>[blockWalls(bool)](#actionblockwalls)</li><li>[checkFloor(bool)](#actioncheckfloor)</li></ul>

> **Example:**
```lua
local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.itemid == 2739 then
		target:transform(2737)
		target:decay()
		Game.createItem(2694, 1, toPosition)
		return true
	end
	return destroyItem(player, target, toPosition)
end

action:id(2550)
action:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="actionid"/>

##### Action:id(ids)
> **Description:** <ul><li>Registers the Action by chosen itemid(s)</li></ul>
> **Parameters:** <ul><li>id(s)</li></ul>
> **Returns:** N/A

> **Example:**
```lua
local action = Action()

action:id(1000) -- only registering one itemid
action:id(1000,1001,1002,...) -- registering several itemids

action:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="actionaid"/>

##### Action:aid(ids)
> **Description:** <ul><li>Registers the Action by chosen actionid(s)</li></ul>
> **Parameters:** <ul><li>aid(s)</li></ul>
> **Returns:** N/A

> **Example:**
```lua
local action = Action()

action:aid(1000) -- only registering one actionid
action:aid(1000,1001,1002,...) -- registering several actionids

action:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="actionuid"/>

##### Action:uid(ids)
> **Description:** <ul><li>Registers the Action by chosen uniqueid(s)</li></ul>
> **Parameters:** <ul><li>uid(s)</li></ul>
> **Returns:** N/A

> **Example:**
```lua
local action = Action()

action:uid(1000) -- only registering one uniqueid
action:uid(1000,1001,1002,...) -- registering several uniqueids

action:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="actionallowfaruse"/>

##### Action:allowFarUse(bool)
> **Description:** <ul><li>Determines whether the item can be used on a target from a distance or not.</li><li>default: false</li></ul>
> **Parameters:** <ul><li>boolean value (true or false)</li></ul>
> **Returns:** N/A

> **Example:**
```lua
local action = Action()

action:allowFarUse(true)

action:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="actionblockwalls"/>

##### Action:blockWalls(bool)
> **Description:** <ul><li>Determines whether the item can be used on a target even if there is a wall between the Player and the target.</li><li>default: true</li></ul>
> **Parameters:** <ul><li>boolean value (true or false)</li></ul>
> **Returns:** N/A

> **Example:**
```lua
local action = Action()

action:blockWalls(false)

action:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="actioncheckfloor"/>

##### Action:checkFloor(bool)
> **Description:** <ul><li>Determines whether the item must be used on a target which is on the same floor level as the Player's.</li><li>default: true</li></ul>
> **Parameters:** <ul><li>boolean value true/false</li></ul>
> **Returns:** N/A

> **Example:**
```lua
local action = Action()

action:checkFloor(false)

action:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="creatureevent"/>

#### CreatureEvent("name")
> **Interfaces:** <ul><li>[onLogin(player)](#creatureevent)</li><li>[onLogout(player)](#creatureeventonLogout)</li><li>[onThink(creature, interval)](#creatureeventonthink)</li><li>[onPrepareDeath(creature, killer)](#creatureeventonpreparedeath)</li><li>[onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)](#creatureeventondeath)</li><li>[onKill(creature, target)](#creatureeventonkill)</li><li>[onAdvance(player, skill, oldLevel, newLevel)](#creatureeventonadvance)</li><li>[onModalWindow(player, modalWindowId, buttonId, choiceId)](#creatureeventonmodalwindow)</li><li>[onTextEdit(player, item, text)](#creatureeventontextedit)</li><li>[onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)](#creatureeventonhealthchange)</li><li>[onManaChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)](#creatureeventonmanachange)</li><li>[onExtendedOpCode(player, opcode, buffer)](#creatureeventonextendedopcode)</li></ul>
> **Methods:** <ul><li>none</li></ul>

> **Example:**
```lua
local creatureevent = CreatureEvent("example")

function creatureevent.onLogin(player)
	player:sendTextMessage(MESSAGE_STATUS_DEFAULT, "Welcome!")
	return true
end

creatureevent:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="creatureeventonlogout"/>

##### CreatureEvent("name").onLogout(player)
> **Interface:** <ul><li>onLogout(player)</li></ul>

> **Example:**
```lua
local creatureevent = CreatureEvent("example")

function creatureevent.onLogout(player)
	player:getPosition():sendMagicEffect(CONST_ME_POFF)
	return true
end

creatureevent:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="creatureeventonthink"/>

##### CreatureEvent("name").onThink(creature, interval)
> **Interface:** <ul><li>onThink(creature, interval)</li></ul>

> **Example:**
```lua
local creatureevent = CreatureEvent("example")

function creatureevent.onThink(creature, interval)
	return true
end

creatureevent:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="creatureeventonpreparedeath"/>

##### CreatureEvent("name").onPrepareDeath(creature, killer)
> **Interface:** <ul><li>onPrepareDeath(creature, killer)</li></ul>

> **Example:**
```lua
local creatureevent = CreatureEvent("example")

function creatureevent.onPrepareDeath(creature, killer)
	return true
end

creatureevent:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="creatureeventondeath"/>

##### CreatureEvent("name").onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
> **Interface:** <ul><li>onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)</li></ul>

> **Example:**
```lua
local creatureevent = CreatureEvent("example")

function creatureevent.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
	return true
end

creatureevent:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="creatureeventonkill"/>

##### CreatureEvent("name").onKill(creature, target)
> **Interface:** <ul><li>onKill(creature, target)</li></ul>

> **Example:**
```lua
local creatureevent = CreatureEvent("example")

function creatureevent.onKill(creature, target)
	return true
end

creatureevent:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="creatureeventonadvance"/>

##### CreatureEvent("name").onAdvance(player, skill, oldLevel, newLevel)
> **Interface:** <ul><li>onAdvance(player, skill, oldLevel, newLevel)</li></ul>

> **Example:**
```lua
local creatureevent = CreatureEvent("example")

function creatureevent.onAdvance(player, skill, oldLevel, newLevel)
	return true
end

creatureevent:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***
***

<a name="creatureeventonmodalwindow"/>

##### CreatureEvent("name").onModalWindow(player, modalWindowId, buttonId, choiceId)
> **Interface:** <ul><li>onModalWindow(player, modalWindowId, buttonId, choiceId)</li></ul>

> **Example:**
```lua
local creatureevent = CreatureEvent("example")

function creatureevent.onModalWindow(player, modalWindowId, buttonId, choiceId)
	return true
end

creatureevent:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="creatureeventontextedit"/>

##### CreatureEvent("name").onTextEdit(player, item, text)
> **Interface:** <ul><li>onTextEdit(player, item, text)</li></ul>

> **Example:**
```lua
local creatureevent = CreatureEvent("example")

function creatureevent.onTextEdit(player, item, text)
	return true
end

creatureevent:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="creatureeventonhealthchange"/>

##### CreatureEvent("name").onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
> **Interface:** <ul><li>onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)</li></ul>

> **Example:**
```lua
local creatureevent = CreatureEvent("example")

function creatureevent.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

creatureevent:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="creatureeventonmanachange"/>

##### CreatureEvent("name").onManaChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
> **Interface:** <ul><li>onManaChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)</li></ul>

> **Example:**
```lua
local creatureevent = CreatureEvent("example")

function creatureevent.onManaChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

creatureevent:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="creatureeventonextendedopcode"/>

##### CreatureEvent("name").onExtendedOpCode(player, opcode, buffer)
> **Interface:** <ul><li>onExtendedOpCode(player, opcode, buffer)</li></ul>

> **Example:**
```lua
local creatureevent = CreatureEvent("example")

function creatureevent.onExtendedOpCode(player, opcode, buffer)
	return true
end

creatureevent:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="globalevent"/>

#### GlobalEvent("name")
> **Interfaces:** <ul><li>[onThink(interval)](#globalevent)</li><li>[onTime(interval)](#globaleventontime)</li><li>[onStartup()](#globaleventonstartup)</li><li>[onShutdown()](#globaleventonshutdown)</li><li>[onRecord(current, old)](#globaleventonrecord)</li></ul>
> **Methods:** <ul><li>[time(time)](#globaleventontime)</li><li>[interval(ms)](#globalevent)</li></ul>

> **Example:**
```lua
local globalevent = GlobalEvent("example")

function globalevent.onThink(...)
	return true
end

globalevent:interval(1000) -- will be executed every 1000ms
globalevent:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="globaleventontime"/>

##### GlobalEvent("name").onTime(interval)
> **Interface:** <ul><li>onTime(interval)</li></ul>

> **Example:**
```lua
local globalevent = GlobalEvent("example")

function globalevent.onTime(interval)
	broadcastMessage("Good morning!", MESSAGE_STATUS_DEFAULT)
	return true
end

globalevent:time("08:00") -- will be executed each day on 8am
globalevent:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="globaleventonstartup"/>

##### GlobalEvent("name").onStartup()
> **Interface:** <ul><li>onStartup()</li></ul>

> **Example:**
```lua
local globalevent = GlobalEvent("example")

function globalevent.onStartup()
	broadcastMessage("Server started!", MESSAGE_STATUS_DEFAULT)
	return true
end

globalevent:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="globaleventonshutdown"/>

##### GlobalEvent("name").onShutdown()
> **Interface:** <ul><li>onShutdown()</li></ul>

> **Example:**
```lua
local globalevent = GlobalEvent("example")

function globalevent.onShutdown()
	broadcastMessage("Shutting down, see you soon!", MESSAGE_STATUS_DEFAULT)
	return true
end

globalevent:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="globaleventonrecord"/>

##### GlobalEvent("name").onRecord(current, old)
> **Interface:** <ul><li>onRecord(current, old)</li></ul>

> **Example:**
```lua
local globalevent = GlobalEvent("example")

function globalevent.onRecord(current, old)
	return true
end

globalevent:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="monstertype"/>

#### MonsterType("name")
> **Description:** <ul><li>We have created a table masking system, in order to make MonsterTypes easier to maintain/create [example](#monstertypetablemaskingexample)</li></ul>
> **Interfaces:** <ul><li>[onThink(...)](#monstertypeonthink)</li><li>[onAppear(...)](#monstertypeonappear)</li><li>[onDisappear()](#monstertypeondisappear)</li><li>[onMove(...)](#monstertypeonmove)</li><li>[onSay(...)](#monstertypeonsay)</li></ul>
> **Methods:** <ul>
	Create a new MonsterType:
	<li>[Game.createMonsterType(name)](#monstertypetablemaskingexample)</li>
	Boolean functions:
	<li>[isAttackable(bool)](#monstertypetablemaskingexample)</li>
	<li>[isConvinceable(bool)](#monstertypetablemaskingexample)</li>
	<li>[isSummonable(bool)](#monstertypetablemaskingexample)</li>
	<li>[isIllusionable(bool)](#monstertypetablemaskingexample)</li>
	<li>[isHostile(bool)](#monstertypetablemaskingexample)</li>
	<li>[isPushable(bool)](#monstertypetablemaskingexample)</li>
	<li>[isHealthHidden(bool)](#monstertypetablemaskingexample)</li>
	<li>[canPushItems(bool)](#monstertypetablemaskingexample)</li>
	<li>[canPushCreatures(bool)](#monstertypetablemaskingexample)</li>
	<li>[canPushCreatures(bool)](#monstertypetablemaskingexample)</li>
	Integer Functions:
	<li>[health(health)](#monstertypetablemaskingexample)</li>
	<li>[maxHealth(maxHealth)](#monstertypetablemaskingexample)</li>
	<li>[experience(exp)](#monstertypetablemaskingexample)</li>
	<li>[addElement(type, percent)](#monstertypetablemaskingexample)</li>
	<li>[maxSummons(ammount)](#monstertypetablemaskingexample)</li>
	<li>[armor(armor)](#monstertypetablemaskingexample)</li>
	<li>[defense(defense)](#monstertypetablemaskingexample)</li>
	<li>[corpseId(id)](#monstertypetablemaskingexample)</li>
	<li>[manaCost(mana)](#monstertypetablemaskingexample)</li>
	<li>[baseSpeed(speed)](#monstertypetablemaskingexample)</li>
	<li>[light(color, level)](#monstertypetablemaskingexample)</li>
	<li>[staticAttackChance(chance)](#monstertypetablemaskingexample)</li>
	<li>[targetDistance(distance)](#monstertypetablemaskingexample)</li>
	<li>[yellChance(chance)](#monstertypetablemaskingexample)</li>
	<li>[yellSpeedTicks(ticks)](#monstertypetablemaskingexample)</li>
	<li>[changeTargetChance(chance)](#monstertypetablemaskingexample)</li>
	<li>[changeTargetSpeed(interval)](#monstertypetablemaskingexample)</li>
	String Functions:
	<li>[name(name)](#monstertypetablemaskingexample)</li>
	<li>[nameDescription(description)](#monstertypetablemaskingexample)</li>
	<li>[combatImmunity(immunity)](#monstertypetablemaskingexample)</li>
	<li>[conditionImmunity(immunity)](#monstertypetablemaskingexample)</li>
	<li>[addVoice(sentence, interval, chance, yell)](#monstertypetablemaskingexample)</li>
	<li>[registerEvent(name)](#monstertypetablemaskingexample)</li>
	<li>[addSummonname, interval, chance)](#monstertypetablemaskingexample)</li>
	<li>[race(race)](#monstertypetablemaskingexample)</li>
	Get Functions:
	<li>[getAttackList()](#monstertypetablemaskingexample)</li>
	<li>[getDefenseList()](#monstertypetablemaskingexample)</li>
	<li>[getElementList()](#monstertypetablemaskingexample)</li>
	<li>[getVoices()](#monstertypetablemaskingexample)</li>
	<li>[getLoot()](#monstertypetablemaskingexample)</li>
	<li>[getCreatureEvents()](#monstertypetablemaskingexample)</li>
	<li>[getSummonList()](#monstertypetablemaskingexample)</li>
	Userdata Functions:
	<li>[addAttack(monsterspell)](#monstertypetablemaskingexample)</li>
	<li>[addDefense(monsterspell)](#monstertypetablemaskingexample)</li>
	<li>[addLoot(loot)](#monstertypetablemaskingexample)</li>
	<li>[outfit(outfit)](#monstertypetablemaskingexample)</li>
	</ul>
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="monstertypetablemaskingexample"/>

##### How to create a MonsterType from scratch.
> **Example:**
```lua
local mType = Game.createMonsterType("example")
local monster = {}
monster.description = "an example"
monster.experience = 1
monster.outfit = {
	lookType = 37
}

monster.health = 99200
monster.maxHealth = monster.health
monster.race = "fire"
monster.corpse = 5995
monster.speed = 280
monster.maxSummons = 2

monster.changeTarget = {
	interval = 4*1000,
	chance = 20
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	targetDistance = 1,
	staticAttackChance = 70
}

monster.summons = {
	{name = "demon", chance = 10, interval = 2*1000}
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{text = "I'm an example", yell = false},
	{text = "You shall bow", yell = false}
}

monster.loot = {
	{id = "gold coin", chance = 60000, maxCount = 100},
	{id = "bag", chance = 60000,
		child = {
			{id = "platinum coin", chance = 60000, maxCount = 100},
			{id = "crystal coin", chance = 60000, maxCount = 100}
		}
	}
}

monster.attacks = {
	{name = "melee", attack = 130, skill = 70, effect = CONST_ME_DRAWBLOOD, interval = 2*1000},
	{name = "energy strike", range = 1, chance = 10, interval = 2*1000, minDamage = -210, maxDamage = -300, target = true},
	{name = "combat", type = COMBAT_MANADRAIN, chance = 10, interval = 2*1000, minDamage = 0, maxDamage = -120, target = true, range = 7, effect = CONST_ME_MAGIC_BLUE},
	{name = "combat", type = COMBAT_FIREDAMAGE, chance = 20, interval = 2*1000, minDamage = -150, maxDamage = -250, radius = 1, target = true, effect = CONST_ME_FIREAREA, shootEffect = CONST_ANI_FIRE},
	{name = "speed", chance = 15, interval = 2*1000, speed = -700, radius = 1, target = true, duration = 30*1000, effect = CONST_ME_MAGIC_RED},
	{name = "firefield", chance = 10, interval = 2*1000, range = 7, radius = 1, target = true, shootEffect = CONST_ANI_FIRE},
	{name = "combat", type = COMBAT_LIFEDRAIN, chance = 10, interval = 2*1000, length = 8, spread = 0, minDamage = -300, maxDamage = -490, effect = CONST_ME_PURPLEENERGY}
}

monster.defenses = {
	defense = 55,
	armor = 55,
	{name = "combat", type = COMBAT_HEALING, chance = 15, interval = 2*1000, minDamage = 180, maxDamage = 250, effect = CONST_ME_MAGIC_BLUE},
	{name = "speed", chance = 15, interval = 2*1000, speed = 320, effect = CONST_ME_MAGIC_RED}
}

monster.elements = {
	{type = COMBAT_PHYSICALDAMAGE, percent = 30},
	{type = COMBAT_DEATHDAMAGE, percent = 30},
	{type = COMBAT_ENERGYDAMAGE, percent = 50},
	{type = COMBAT_EARTHDAMAGE, percent = 40},
	{type = COMBAT_ICEDAMAGE, percent = -10},
	{type = COMBAT_HOLYDAMAGE, percent = -10}
}

monster.immunities = {
	{type = "fire", combat = true, condition = true},
	{type = "drown", condition = true},
	{type = "lifedrain", combat = true},
	{type = "paralyze", condition = true},
	{type = "invisible", condition = true}
}

mType.onThink = function(monster, interval)
	print("I'm thinking")
end

mType.onAppear = function(monster, creature)
	if monster:getId() == creature:getId() then
		print(monster:getId(), creature:getId())
	end
end

mType.onDisappear = function(monster, creature)
	if monster:getId() == creature:getId() then
		print(monster:getId(), creature:getId())
	end
end

mType.onMove = function(monster, creature, fromPosition, toPosition)
	if monster:getId() == creature:getId() then
		print(monster:getId(), creature:getId(), fromPosition, toPosition)
	end
end

mType.onSay = function(monster, creature, type, message)
	print(monster:getId(), creature:getId(), type, message)
end

mType:register(monster)
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="moveevent"/>

#### MoveEvent()
> **Interfaces:** <ul><li>[onEquip(player, item, slot, isCheck)](#moveeventonEquip)</li><li>[onDeEquip(player, item, slot, isCheck)](#moveeventonDeEquip)</li><li>[onStepIn(creature, item, position, fromPosition)](#moveeventonStepIn)</li><li>[onStepOut(creature, item, position, fromPosition)](#moveeventonStepOut)</li><li>[onAddItem(moveitem, tileitem, position)](#moveeventonAddItem)</li><li>[onRemoveItem(moveitem, tileitem, position)](#moveeventonRemoveItem)</li></ul>
> **Methods:** <ul><li>[level(lvl)](#moveeventlevel)</li><li>[magiclevel(lvl)](#moveeventmagiclevel)</li><li>[slot(slot)](#moveeventslot)</li><li>[id(ids)](#moveeventid)</li><li>[aid(ids)](#moveeventaid)</li><li>[uid(ids)](#moveeventuid)</li><li>[position(positions)](#moveeventposition)</li><li>[premium(bool)](#moveeventpremium)</li><li>[vocation(vocName[, showInDescription = false, lastVoc = false])](#moveeventvocation)</li></ul>

> **Example:**
```lua
local moveevent = MoveEvent()

function moveevent.onEquip(player, item, slot, isCheck)
	return true
end

moveevent:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="moveeventonEquip"/>

##### MoveEvent().onEquip(player, item, slot, isCheck)
> **Interface:** <ul><li>onEquip(player, item, slot, isCheck)</li></ul>

> **Example:**
```lua
local moveevent = MoveEvent()

function moveevent.onEquip(player, item, slot, isCheck)
	return true
end

moveevent:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="moveeventonDeEquip"/>

##### MoveEvent().onDeEquip(player, item, slot, isCheck)
> **Interface:** <ul><li>onDeEquip(player, item, slot, isCheck)</li></ul>

> **Example:**
```lua
local moveevent = MoveEvent()

function moveevent.onDeEquip(player, item, slot, isCheck)
	return true
end

moveevent:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="moveeventonStepIn"/>

##### MoveEvent().onStepIn(creature, item, position, fromPosition)
> **Interface:** <ul><li>onStepIn(creature, item, position, fromPosition)></ul>

> **Example:**
```lua
local moveevent = MoveEvent()

function moveevent.onStepIn(creature, item, position, fromPosition)
	return true
end

moveevent:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="moveeventonStepOut"/>

##### MoveEvent().onStepOut(creature, item, position, fromPosition)
> **Interface:** <ul><li>onStepOut(creature, item, position, fromPosition)></ul>

> **Example:**
```lua
local moveevent = MoveEvent()

function moveevent.onStepOut(creature, item, position, fromPosition)
	return true
end

moveevent:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="moveeventonAddItem"/>

##### MoveEvent().onAddItem(moveitem, tileitem, position)
> **Interface:** <ul><li>onAddItem(moveitem, tileitem, position)></ul>

> **Example:**
```lua
local moveevent = MoveEvent()

function moveevent.onAddItem(moveitem, tileitem, position)
	return true
end

moveevent:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="moveeventonRemoveItem"/>

##### MoveEvent().onRemoveItem(moveitem, tileitem, position)
> **Interface:** <ul><li>onAddItem(moveitem, tileitem, position)></ul> **Returns:** N/A

> **Example:**
```lua
local moveevent = MoveEvent()

function moveevent.onRemoveItem(moveitem, tileitem, position)
	return true
end

moveevent:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="moveeventlevel"/>

##### MoveEvent:level(lvl)
> **Description:** <ul><li>Registers the MoveEvent by chosen level</li></ul>
> **Parameters:** <ul><li>id(s)</li></ul>
> **Returns:** N/A

> **Example:**
```lua
local moveevent = MoveEvent()

moveevent:level(50)

moveevent:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***
<a name="moveeventmagiclevel"/>

##### MoveEvent:magiclevel(lvl)
> **Description:** <ul><li>Registers the MoveEvent by chosen magic level</li></ul>
> **Parameters:** <ul><li>id(s)</li></ul>
> **Returns:** N/A

> **Example:**
```lua
local moveevent = MoveEvent()

moveevent:magiclevel(25)

moveevent:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***
<a name="moveeventid"/>

##### MoveEvent:id(ids)
> **Description:** <ul><li>Registers the MoveEvent by chosen itemid(s)</li></ul>
> **Parameters:** <ul><li>id(s)</li></ul>
> **Returns:** N/A

> **Example:**
```lua
local moveevent = MoveEvent()

moveevent:id(1000) -- only registering one itemid
moveevent:id(1000,1001,1002,...) -- registering several itemids

moveevent:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="moveeventaid"/>

##### MoveEvent:aid(ids)
> **Description:** <ul><li>Registers the MoveEvent by chosen actionid(s)</li></ul>
> **Parameters:** <ul><li>aid(s)</li></ul>
> **Returns:** N/A

> **Example:**
```lua
local moveevent = MoveEvent()

moveevent:aid(1000) -- only registering one actionid
moveevent:aid(1000,1001,1002,...) -- registering several actionids

moveevent:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="moveeventuid"/>

##### MoveEvent:uid(ids)
> **Description:** <ul><li>Registers the MoveEvent by chosen uniqueid(s)</li></ul>
> **Parameters:** <ul><li>uid(s)</li></ul>
> **Returns:** N/A

> **Example:**
```lua
local moveevent = MoveEvent()

moveevent:uid(1000) -- only registering one uniqueid
moveevent:uid(1000,1001,1002,...) -- registering several uniqueids

moveevent:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="moveeventposition"/>

##### MoveEvent:position(positions)
> **Description:** <ul><li>Registers the MoveEvent by chosen position(s)</li></ul>
> **Parameters:** <ul><li>position(s)</li></ul>
> **Returns:** N/A

> **Example:**
```lua
local moveevent = MoveEvent()

moveevent:position({x = 0, y = 0, z = 0}) -- only registering one position

moveevent:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="moveeventpremium"/>

##### MoveEvent:premium(bool)
> **Description:** <ul><li>Determines whether the MoveEvent will be triggered by premium players or not</li><li>default: false</li></ul>
> **Parameters:** <ul><li>boolean value (true or false)</li></ul>
> **Returns:** N/A

> **Example:**
```lua
local moveevent = MoveEvent()

moveevent:premium(true)

moveevent:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="moveeventvocation"/>

##### MoveEvent:vocation(vocName[, showInDescription = false, lastVoc = false])
> **Description:** <ul><li>Determines whether the MoveEvent will be triggered by a specific vocation. Optional parameters will determine if the vocation specified will be shown in the description and if it is the last vocation shown in description.<li></ul>
> **Parameters:** <ul><li>vocName (string), showInDescription (boolean), lastVoc</li></ul>
> **Returns:** N/A

> **Example:**
```lua
local moveevent = MoveEvent()

moveevent:vocation("Sorcerer", true, true) -- 

moveevent:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="spell"/>

#### Spell(words, name or id)
> **Interfaces:** <ul><li>[onCastSpell(creature, var, isHotkey)](#spelloncastspell)</li></ul>
> **Methods:** <ul><li>[getManaCost(player)](#spellgetmanacost)</li><li>[getSoulCost()](#spellgetsoulcost)</li><li>[isPremium()](#spellispremium)</li><li>[isLearnable()](#spellislearnable)</li></ul>

> **Example:**
```lua
local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)
combat:setArea(createCombatArea(AREA_CIRCLE5X5))

function onGetFormulaValues(player, level, magicLevel)
	local min = (level / 5) + (magicLevel * 8) + 50
	local max = (level / 5) + (magicLevel * 12) + 75
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end

spell:name("Hell's Core")
spell:words("exevo gran mas flam")
spell:group("attack")
spell:vocation("sorcerer", "master sorcerer")
spell:id(24)
spell:cooldown(40 * 1000)
spell:groupCooldown(4 * 1000)
spell:level(60)
spell:mana(1100)
spell:isSelfTarget(true)
spell:isPremium(true)
spell:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="spelloncastspell"/>

##### Spell(words, name or id).onCastSpell(creature, var, isHotkey)
> **Interface:** <ul><li>onCastSpell(creature, var, isHotkey)</li></ul> **Returns:** N/A

> **Example:**
```lua
local spell = Spell("Hell's Core")

function spell.onCastSpell(creature, var, isHotkey)
	return true
end

spell:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="spellgetmanacost"/>

##### Spell:getManaCost(player)
> **Description:** <ul><li>Returns the mana that the player will spend when casting the spell</li></ul>
> **Parameters:** <ul><li>player</li></ul>
> **Returns:** N/A

> **Example:**
```lua
local spell = Spell("Hell's Core")

function spell.onCastSpell(creature, var, isHotkey)
	if spell:getManaCost(creature) >= 500 then
		creature:sendTextMessage(MESSAGE_STATUS_DEFAULT, "You spent 500 mana or more while casting this spell!")
	else
		creature:sendTextMessage(MESSAGE_STATUS_DEFAULT, "You spent less than 500 mana right now.")
	end
	return true
end

spell:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="spellgetsoulcost"/>

##### Spell:getSoulCost()
> **Description:** <ul><li>Returns the soul that the player will spend when casting the spell</li></ul>
> **Parameters:** <ul><li>none</li></ul>
> **Returns:** N/A

> **Example:**
```lua
local spell = Spell("Hell's Core")

function spell.onCastSpell(creature, var, isHotkey)
	if spell:getSoulCost() >= 50 then
		creature:sendTextMessage(MESSAGE_STATUS_DEFAULT, "You just lost half your soul (at least)!")
	else
		creature:sendTextMessage(MESSAGE_STATUS_DEFAULT, "You didn't spend too much soul when casting this spell.")
	end
	return true
end

spell:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="spellispremium"/>

##### Spell:isPremium()
> **Description:** <ul><li>Returns whether the player that cast the spell is premium or not</li></ul>
> **Parameters:** <ul><li>none</li></ul>
> **Returns:** N/A

> **Example:**
```lua
local spell = Spell("Hell's Core")

function spell.onCastSpell(creature, var, isHotkey)
	if spell:isPremium() then
		creature:sendTextMessage(MESSAGE_STATUS_DEFAULT, "You are premium.")
	else
		creature:sendTextMessage(MESSAGE_STATUS_DEFAULT, "You are not premium.")
	end
	return true
end

spell:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="spellislearnable"/>

##### Spell:isLearnable()
> **Description:** <ul><li>Returns whether the player that cast the spell is able to learn the spell or not</li></ul>
> **Parameters:** <ul><li>none</li></ul>
> **Returns:** N/A

> **Example:**
```lua
local spell = Spell("Hell's Core")

function spell.onCastSpell(creature, var, isHotkey)
	if spell:isLearnable() then
		creature:sendTextMessage(MESSAGE_STATUS_DEFAULT, "You may learn this spell when you become more powerful!")
	else
		creature:sendTextMessage(MESSAGE_STATUS_DEFAULT, "This spell is not suitable for you...")
	end
	return true
end

spell:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="talkaction"/>

#### TalkAction(words)
> **Interfaces:** <ul><li>[onSay(callback)](#talkactiononsay)</li></ul>
> **Methods:** <ul><li>[separator(sep)](#talkactionseparator)</li></ul>

> **Example:**
```lua
local talkaction = TalkAction("!hello")

function talkaction.onSay(player, words, param, type)
	player:say("Hello!", TALKTYPE_YELL)
	return true
end

talkaction:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="talkactiononsay"/>

##### TalkAction(words).onSay(callback)
> **Interface:** <ul><li>onSay(callback)</li></ul> **Returns:** N/A

> **Example:**
```lua
local talkaction = TalkAction("!bye")

function talkaction.onSay(player, words, param, type)
	player:say("Bye...", TALKTYPE_WHISPER)
	return true
end

talkaction:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="talkactionseparator"/>

##### TalkAction:separator(sep)
> **Description:** <ul><li>Determines talkaction separator</li></ul>
> **Parameters:** <ul><li>sep</li></ul>
> **Returns:** N/A

> **Example:**
```lua
local talkaction = TalkAction("!bye")

talkaction:separator("-")

talkaction:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="weapon"/>

#### Weapon(WEAPON_TYPE)
> **Interfaces:** <ul><li>[onUseWeapon(player, var)](#weapononuseweapon)</li></ul>
> **Methods:** <ul><li>[separator(sep)](#talkactionseparator)</li></ul>

> **Example:**
```lua
local weapon = Weapon(WEAPON_AMMO)

local area = createCombatArea({
	{1, 1, 1},
	{1, 3, 1},
	{1, 1, 1}
})

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_EXPLOSIONAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_BURSTARROW)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
combat:setFormula(COMBAT_FORMULA_SKILL, 0, 0, 1, 0)
combat:setArea(area)

function weapon.onUseWeapon(player, variant)
	if player:getSkull() == SKULL_BLACK then
		return false
	end

	return combat:execute(player, variant)
end

weapon:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***

<a name="weapononuseweapon"/>

##### Weapon(WEAPON_TYPE).onUseWeapon(player, variant)
> **Interface:** <ul><li>onUseWeapon(player, variant)</li></ul> **Returns:** N/A

> **Example:**
```lua
local weapon = Weapon(WEAPON_AMMO)

local area = createCombatArea({
	{1, 1, 1},
	{1, 3, 1},
	{1, 1, 1}
})

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_EXPLOSIONAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_BURSTARROW)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
combat:setFormula(COMBAT_FORMULA_SKILL, 0, 0, 1, 0)
combat:setArea(area)

-- variant.number = target id
function weapon.onUseWeapon(player, variant)
	if player:getSkull() == SKULL_BLACK then
		return false
	end

	return combat:execute(player, variant)
end

weapon:register()
```
> **Added in version:** 1.3
>
> [To the top](To the top)(#wiki-wrapper)

***

***
