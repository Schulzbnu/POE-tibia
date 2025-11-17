The Player metatable contains all of the methods that handle/require players.  
The player metatable is an extention of the [Creature](creature.md) metatable, and so can handle those methods as well.  
Creating an instance of the Player metatable (2 options):
```Lua
local player = Player(uid)
local player = Player(name or wildcard)
```
### Available methods:
[addBlessing(blessing)](#addBlessing)  
[addExperience(experience, sendText = false)](#addExperience)  
[addItem(itemId, count = 1, canDropOnMap = true, subType = 1, slot = CONST_SLOT_WHEREEVER)](#addItem)  
[addItemEx(item, canDropOnMap = false, index = INDEX_WHEREEVER, flags = 0)](#addItemEx)  
[addItemEx(item, canDropOnMap = true, slot = CONST_SLOT_WHEREEVER)](#addItemEx)  
[addManaSpent(amount)](#addManaSpent)  
[addMapMark(position, type, description)](#addMapMark)  
[addMoney(money)](#addMoney)  
[addMount(mountId)](#addMount)  
[addOutfit(lookType)](#addOutfit)  
[addOutfitAddon(lookType, addon)](#addOutfitAddon)  
[addPremiumDays(days)](#addPremiumDays)  
[addSkillTries(skillType, tries)](#addSkillTries)  
[addSoul(soulChange)](#addSoul)  
[canLearnSpell(spellName)](#canLearnSpell)  
[channelSay(speaker, type, text, channelId)](#channelSay)  
[forgetSpell(spellName)](#forgetSpell)  
[getAccountId()](#getAccountId)  
[getAccountType()](#getAccountType)  
[getBankBalance()](#getBankBalance)  
[getBaseMagicLevel()](#getBaseMagicLevel)  
[getCapacity()](#getCapacity)  
[getClient()](#getClient)  
[getContainerById(id)](#getContainerById)  
[getContainerId(container)](#getContainerId)  
[getContainerIndex(id)](#getContainerIndex)  
[getDeathPenalty()](#getDeathPenalty)  
[getDepotChest(depotId, autoCreate = false)](#getDepotChest)  
[getEffectiveSkillLevel(skillType)](#getEffectiveSkillLevel)  
[getExperience()](#getExperience)  
[getFreeCapacity()](#getFreeCapacity)  
[getGroup()](#getGroup)  
[getGuid()](#getGuid)  
[getGuild()](#getGuild)  
[getGuildLevel()](#getGuildLevel)  
[getGuildNick()](#getGuildNick)  
[getHouse()](#getHouse)  
[getInbox()](#getInbox)  
[getIp()](#getIp)  
[getItemById(itemId, deepSearch, subType = -1)](#getItemById)  
[getItemCount(itemId, subType = -1)](#getItemCount)  
[getLastLoginSaved()](#getLastLoginSaved)  
[getLastLogout()](#getLastLogout)  
[getLevel()](#getLevel)  
[getMagicLevel()](#getMagicLevel)  
[getManaSpent()](#getManaSpent)  
[getMaxSoul()](#getMaxSoul)  
[getMoney()](#getMoney)  
[getParty()](#getParty)  
[getPremiumDays()](#getPremiumDays)  
[getSex()](#getSex)  
[getSkillLevel(skillType)](#getSkillLevel)  
[getSkillPercent(skillType)](#getSkillPercent)  
[getSkillTries(skillType)](#getSkillTries)  
[getSkullTime()](#getSkullTime)  
[getSlotItem(slot)](#getSlotItem)  
[getSoul()](#getSoul)  
[getStamina()](#getStamina)  
[getStorageValue(key)](#getStorageValue)  
[getTown()](#getTown)  
[getVocation()](#getVocation)  
[hasBlessing(blessing)](#hasBlessing)  
[hasLearnedSpell(spellName)](#hasLearnedSpell)  
[hasMount(mountId)](#hasMount)  
[hasOutfit(lookType, addon = 0)](#hasOutfit)  
[isPlayer()](#isPlayer)  
[isPzLocked()](#isPzLocked)  
[learnSpell(spellName)](#learnSpell)  
[openChannel(channelId)](#openChannel)  
[popupFYI(message)](#popupFYI)  
[removeBlessing(blessing)](#removeBlessing)  
[removeExperience(experience, sendText = false)](#removeExperience)  
[removeItem(itemId, count, subType = -1, ignoreEquipped = false)](#removeItem)  
[removeMoney(money)](#removeMoney)  
[removeMount(mountId)](#removeMount)  
[removeOutfit(lookType)](#removeOutfit)  
[removeOutfitAddon(lookType, addon)](#removeOutfitAddon)  
[removePremiumDays(days)](#removePremiumDays)  
[save()](#save)  
[sendChannelMessage(author, text, type, channelId)](#sendChannelMessage)  
[sendOutfitWindow()](#sendOutfitWindow)  
[sendPrivateMessage(speaker, text, type)](#sendPrivateMessage)  
[sendTextMessage(type, text, position, primaryValue = 0, primaryColor = TEXTCOLOR_NONE, secondaryValue = 0, secondaryColor = TEXTCOLOR_NONE)](#sendTextMessage)  
[sendTutorial(tutorialId)](#sendTutorial)  
[setAccountType(accountType)](#setAccountType)  
[setBankBalance(bankBalance)](#setBankBalance)  
[setCapacity(capacity)](#setCapacity)  
[setGhostMode(enabled)](#setGhostMode)  
[setGroup(group)](#setGroup)  
[setGuild(guild)](#setGuild)  
[setGuildLevel(level)](#setGuildLevel)  
[setGuildNick(nick)](#setGuildNick)  
[setMaxMana(maxMana)](#setMaxMana)  
[setSex(newSex)](#setSex)  
[setSkullTime(skullTime)](#setSkullTime)  
[setStamina(stamina)](#setStamina)  
[setStorageValue(key, value)](#setStorageValue)  
[setTown(town)](#setTown)  
[setVocation(vocation)](#setVocation)  
[showTextDialog(itemId, text, canWrite, length)](#showTextDialog)  


***

<a name="addBlessing"/>

##### addBlessing(blessing)
> **Description:** N/A  
> **Parameters:** <ul><li>_blessing_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:addBlessing(1)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="addExperience"/>

##### addExperience(experience[, sendText = false])
> **Description:** N/A  
> **Parameters:** <ul><li>_experience_ - _No description_</li><li>_sendText_ - _(optional, default: false)_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:addExperience(100, false)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="addItem"/>

##### addItem(itemId[, count = 1[, canDropOnMap = true[, subType = 1[, slot = CONST_SLOT_WHEREEVER]]]])
> **Description:** This function gives the player a newly created item.  
> **Parameters:** <ul><li>_itemId_ - _Type of item created._</li><li>_count_ - _How many items that are created. (optional, default = 1)_</li><li>_canDropOnMap_ - _Drops any remaining items on the map. (optional, default: true)_</li><li>_subType_ - _Subtype the item(s) should have. (optional, default: 1)_</li><li>_slot_ - _Slot the item should be assigned to. (optional, default: CONST_SLOT_WHEREEVER)_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:addItem(2400, 1, true, 1, CONST_SLOT_WHEREEVER)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="addItemEx"/>

##### addItemEx(item[, canDropOnMap = false[, index = INDEX_WHEREEVER[, flags = 0]]])
> **Description:** N/A  
> **Parameters:** <ul><li>_item_ - _No description_</li><li>_canDropOnMap_ - _(optional, default: false)_</li><li>_index_ - _(optional, default: INDEX_WHEREEVER)_</li><li>_flags_ - _(optional, default: 0)_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:addItemEx(some_userdata, false, INDEX_WHEREEVER, 0)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="addItemEx"/>

##### addItemEx(item[, canDropOnMap = true[, slot = CONST_SLOT_WHEREEVER]])
> **Description:** N/A  
> **Parameters:** <ul><li>_item_ - _No description_</li><li>_canDropOnMap_ - _(optional, default: true)_</li><li>_slot_ - _(optional, default: CONST_SLOT_WHEREEVER)_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:addItemEx(some_userdata, true, CONST_SLOT_WHEREEVER)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="addManaSpent"/>

##### addManaSpent(amount)
> **Description:** N/A  
> **Parameters:** <ul><li>_amount_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:addManaSpent(100)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="addMapMark"/>

##### addMapMark(position, type, description)
> **Description:** N/A  
> **Parameters:** <ul><li>_position_ - _No description_</li><li>_type_ - _No description_</li><li>_description_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:addMapMark(Position(), MAPMARK_LOCK, any_string)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="addMoney"/>

##### addMoney(money)
> **Description:** N/A  
> **Parameters:** <ul><li>_money_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:addMoney(100)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="addMount"/>

##### addMount(mountId)
> **Description:** N/A  
> **Parameters:** <ul><li>_mountId_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:addMount(unknown)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="addOutfit"/>

##### addOutfit(lookType)
> **Description:** N/A  
> **Parameters:** <ul><li>_lookType_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:addOutfit(128)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="addOutfitAddon"/>

##### addOutfitAddon(lookType, addon)
> **Description:** N/A  
> **Parameters:** <ul><li>_lookType_ - _No description_</li><li>_addon_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:addOutfitAddon(128, 2)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="addPremiumDays"/>

##### addPremiumDays(days)
> **Description:** N/A  
> **Parameters:** <ul><li>_days_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:addPremiumDays(1)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="addSkillTries"/>

##### addSkillTries(skillType, tries)
> **Description:** N/A  
> **Parameters:** <ul><li>_skillType_ - _No description_</li><li>_tries_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:addSkillTries(SKILL_FIST, 10)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="addSoul"/>

##### addSoul(soulChange)
> **Description:** N/A  
> **Parameters:** <ul><li>_soulChange_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:addSoul(1)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="canLearnSpell"/>

##### canLearnSpell(spellName)
> **Description:** N/A  
> **Parameters:** <ul><li>_spellName_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:canLearnSpell(unknown)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="channelSay"/>

##### channelSay(speaker, type, text, channelId)
> **Description:** N/A  
> **Parameters:** <ul><li>_speaker_ - _No description_</li><li>_type_ - _No description_</li><li>_text_ - _The sentence you want the recipient to read_</li><li>_channelId_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:channelSay(some_userdata, TALKTYPE_SAY, any_string, unknown)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="forgetSpell"/>

##### forgetSpell(spellName)
> **Description:** N/A  
> **Parameters:** <ul><li>_spellName_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:forgetSpell(unknown)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getAccountId"/>

##### getAccountId()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getAccountId()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getAccountType"/>

##### getAccountType()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getAccountType()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getBankBalance"/>

##### getBankBalance()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getBankBalance()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getBaseMagicLevel"/>

##### getBaseMagicLevel()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getBaseMagicLevel()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getCapacity"/>

##### getCapacity()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getCapacity()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getClient"/>

##### getClient()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getClient()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getContainerById"/>

##### getContainerById(id)
> **Description:** N/A  
> **Parameters:** <ul><li>_id_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getContainerById(some_id)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getContainerId"/>

##### getContainerId(container)
> **Description:** N/A  
> **Parameters:** <ul><li>_container_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getContainerId(some_userdata)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getContainerIndex"/>

##### getContainerIndex(id)
> **Description:** N/A  
> **Parameters:** <ul><li>_id_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getContainerIndex(some_id)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getDeathPenalty"/>

##### getDeathPenalty()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getDeathPenalty()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getDepotChest"/>

##### getDepotChest(depotId[, autoCreate = false])
> **Description:** N/A  
> **Parameters:** <ul><li>_depotId_ - _No description_</li><li>_autoCreate_ - _(optional, default: false)_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getDepotChest(0, false)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getEffectiveSkillLevel"/>

##### getEffectiveSkillLevel(skillType)
> **Description:** N/A  
> **Parameters:** <ul><li>_skillType_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getEffectiveSkillLevel(SKILL_FIST)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getExperience"/>

##### getExperience()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getExperience()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getFreeCapacity"/>

##### getFreeCapacity()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getFreeCapacity()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getGroup"/>

##### getGroup()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getGroup()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getGuid"/>

##### getGuid()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getGuid()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getGuild"/>

##### getGuild()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getGuild()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getGuildLevel"/>

##### getGuildLevel()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getGuildLevel()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getGuildNick"/>

##### getGuildNick()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getGuildNick()
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
local player = Player(...)
player:getHouse()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getInbox"/>

##### getInbox()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getInbox()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getIp"/>

##### getIp()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getIp()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getItemById"/>

##### getItemById(itemId, deepSearch[, subType = -1])
> **Description:** N/A  
> **Parameters:** <ul><li>_itemId_ - _No description_</li><li>_deepSearch_ - _No description_</li><li>_subType_ - _(optional, default: -1)_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getItemById(2400, false, -1)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getItemCount"/>

##### getItemCount(itemId[, subType = -1])
> **Description:** N/A  
> **Parameters:** <ul><li>_itemId_ - _No description_</li><li>_subType_ - _(optional, default: -1)_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getItemCount(2400, -1)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getLastLoginSaved"/>

##### getLastLoginSaved()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getLastLoginSaved()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getLastLogout"/>

##### getLastLogout()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getLastLogout()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.1

***

<a name="getLevel"/>

##### getLevel()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getLevel()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getMagicLevel"/>

##### getMagicLevel()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getMagicLevel()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getManaSpent"/>

##### getManaSpent()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getManaSpent()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getMaxSoul"/>

##### getMaxSoul()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getMaxSoul()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getMoney"/>

##### getMoney()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getMoney()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getParty"/>

##### getParty()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getParty()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getPremiumDays"/>

##### getPremiumDays()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getPremiumDays()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getSex"/>

##### getSex()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getSex()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getSkillLevel"/>

##### getSkillLevel(skillType)
> **Description:** N/A  
> **Parameters:** <ul><li>_skillType_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getSkillLevel(SKILL_FIST)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getSkillPercent"/>

##### getSkillPercent(skillType)
> **Description:** N/A  
> **Parameters:** <ul><li>_skillType_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getSkillPercent(SKILL_FIST)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getSkillTries"/>

##### getSkillTries(skillType)
> **Description:** N/A  
> **Parameters:** <ul><li>_skillType_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getSkillTries(SKILL_FIST)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getSkullTime"/>

##### getSkullTime()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getSkullTime()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getSlotItem"/>

##### getSlotItem(slot)
> **Description:** N/A  
> **Parameters:** <ul><li>_slot_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getSlotItem(CONST_SLOT_LEFT)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getSoul"/>

##### getSoul()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getSoul()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getStamina"/>

##### getStamina()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getStamina()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getStorageValue"/>

##### getStorageValue(key)
> **Description:** N/A  
> **Parameters:** <ul><li>_key_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getStorageValue(1000)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getTown"/>

##### getTown()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getTown()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="getVocation"/>

##### getVocation()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:getVocation()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="hasBlessing"/>

##### hasBlessing(blessing)
> **Description:** N/A  
> **Parameters:** <ul><li>_blessing_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:hasBlessing(1)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="hasLearnedSpell"/>

##### hasLearnedSpell(spellName)
> **Description:** N/A  
> **Parameters:** <ul><li>_spellName_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:hasLearnedSpell(unknown)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="hasMount"/>

##### hasMount(mountId)
> **Description:** N/A  
> **Parameters:** <ul><li>_mountId_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:hasMount(unknown)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="hasOutfit"/>

##### hasOutfit(lookType[, addon = 0])
> **Description:** N/A  
> **Parameters:** <ul><li>_lookType_ - _No description_</li><li>_addon_ - _(optional, default: 0)_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:hasOutfit(128, 0)
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
local player = Player(...)
player:isPlayer()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="isPzLocked"/>

##### isPzLocked()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:isPzLocked()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="learnSpell"/>

##### learnSpell(spellName)
> **Description:** N/A  
> **Parameters:** <ul><li>_spellName_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:learnSpell(unknown)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="openChannel"/>

##### openChannel(channelId)
> **Description:** N/A  
> **Parameters:** <ul><li>_channelId_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:openChannel(unknown)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="popupFYI"/>

##### popupFYI(message)
> **Description:** N/A  
> **Parameters:** <ul><li>_message_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:popupFYI(any_string)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="removeBlessing"/>

##### removeBlessing(blessing)
> **Description:** N/A  
> **Parameters:** <ul><li>_blessing_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:removeBlessing(1)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="removeExperience"/>

##### removeExperience(experience[, sendText = false])
> **Description:** N/A  
> **Parameters:** <ul><li>_experience_ - _No description_</li><li>_sendText_ - _(optional, default: false)_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:removeExperience(100, false)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="removeItem"/>

##### removeItem(itemId, count[, subType = -1[, ignoreEquipped = false]])
> **Description:** N/A  
> **Parameters:** <ul><li>_itemId_ - _No description_</li><li>_count_ - _No description_</li><li>_subType_ - _(optional, default: -1)_</li><li>_ignoreEquipped_ - _(optional, default: false)_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:removeItem(2400, 1, -1, false)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="removeMoney"/>

##### removeMoney(money)
> **Description:** N/A  
> **Parameters:** <ul><li>_money_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:removeMoney(100)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="removeMount"/>

##### removeMount(mountId)
> **Description:** N/A  
> **Parameters:** <ul><li>_mountId_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:removeMount(unknown)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="removeOutfit"/>

##### removeOutfit(lookType)
> **Description:** N/A  
> **Parameters:** <ul><li>_lookType_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:removeOutfit(128)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="removeOutfitAddon"/>

##### removeOutfitAddon(lookType, addon)
> **Description:** N/A  
> **Parameters:** <ul><li>_lookType_ - _No description_</li><li>_addon_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:removeOutfitAddon(128, 2)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="removePremiumDays"/>

##### removePremiumDays(days)
> **Description:** N/A  
> **Parameters:** <ul><li>_days_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:removePremiumDays(1)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="save"/>

##### save()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:save()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="sendChannelMessage"/>

##### sendChannelMessage(author, text, type, channelId)
> **Description:** N/A  
> **Parameters:** <ul><li>_author_ - _No description_</li><li>_text_ - _The sentence you want the recipient to read_</li><li>_type_ - _No description_</li><li>_channelId_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:sendChannelMessage(some_name, any_string, TALKTYPE_SAY, unknown)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="sendOutfitWindow"/>

##### sendOutfitWindow()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:sendOutfitWindow()
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="sendPrivateMessage"/>

##### sendPrivateMessage(speaker, text[, type])
> **Description:** N/A  
> **Parameters:** <ul><li>_speaker_ - _No description_</li><li>_text_ - _The sentence you want the recipient to read_</li><li>_[TalkType](Constants#TalkType)_ - _(optional)_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:sendPrivateMessage(some_userdata, any_string, nil)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="sendTextMessage"/>

##### sendTextMessage(type, text[, position, primaryValue = 0, primaryColor = TEXTCOLOR_NONE[, secondaryValue = 0, secondaryColor = TEXTCOLOR_NONE]])
> **Description:** N/A  
> **Parameters:** <ul><li>_[Message type](Constants#Message)_ - _No description_</li><li>_text_ - _The sentence you want the recipient to read_</li><li>_[position](position.md)_ - _(optional)_</li><li>_primaryValue_ - _(optional, default: 0)_</li><li>_primaryColor_ - _(optional, default: TEXTCOLOR_NONE)_</li><li>_secondaryValue_ - _(optional, default: 0)_</li><li>_secondaryColor_ - _(optional, default: TEXTCOLOR_NONE)_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:sendTextMessage(MESSAGE_STATUS_WARNING, any_string, nil, 0, TEXTCOLOR_NONE, 0, TEXTCOLOR_NONE)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="sendTutorial"/>

##### sendTutorial(tutorialId)
> **Description:** N/A  
> **Parameters:** <ul><li>_tutorialId_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:sendTutorial(unknown)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="setAccountType"/>

##### setAccountType(accountType)
> **Description:** N/A  
> **Parameters:** <ul><li>_accountType_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:setAccountType(ACCOUNT_TYPE_GOD)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="setBankBalance"/>

##### setBankBalance(bankBalance)
> **Description:** N/A  
> **Parameters:** <ul><li>_bankBalance_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:setBankBalance(100)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="setCapacity"/>

##### setCapacity(capacity)
> **Description:** N/A  
> **Parameters:** <ul><li>_capacity_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:setCapacity(15000)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="setGhostMode"/>

##### setGhostMode(enabled)
> **Description:** N/A  
> **Parameters:** <ul><li>_enabled_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:setGhostMode(true)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="setGroup"/>

##### setGroup(group)
> **Description:** N/A  
> **Parameters:** <ul><li>_group_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:setGroup(some_userdata)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="setGuild"/>

##### setGuild(guild)
> **Description:** N/A  
> **Parameters:** <ul><li>_guild_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:setGuild(some_userdata)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="setGuildLevel"/>

##### setGuildLevel(level)
> **Description:** N/A  
> **Parameters:** <ul><li>_level_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:setGuildLevel(1)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="setGuildNick"/>

##### setGuildNick(nick)
> **Description:** N/A  
> **Parameters:** <ul><li>_nick_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:setGuildNick(some_name)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="setMaxMana"/>

##### setMaxMana(maxMana)
> **Description:** N/A  
> **Parameters:** <ul><li>_maxMana_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:setMaxMana(35)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="setSex"/>

##### setSex(newSex)
> **Description:** N/A  
> **Parameters:** <ul><li>_newSex_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:setSex(PLAYERSEX_MALE)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="setSkullTime"/>

##### setSkullTime(skullTime)
> **Description:** N/A  
> **Parameters:** <ul><li>_skullTime_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:setSkullTime(unknown)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="setStamina"/>

##### setStamina(stamina)
> **Description:** N/A  
> **Parameters:** <ul><li>_stamina_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:setStamina(50)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="setStorageValue"/>

##### setStorageValue(key, value)
> **Description:** N/A  
> **Parameters:** <ul><li>_key_ - _No description_</li><li>_value_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:setStorageValue(1000, any_number)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="setTown"/>

##### setTown(town)
> **Description:** N/A  
> **Parameters:** <ul><li>_town_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:setTown(Town(0))
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="setVocation"/>

##### setVocation(vocation)
> **Description:** N/A  
> **Parameters:** <ul><li>_vocation_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:setVocation(some_userdata)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0

***

<a name="showTextDialog"/>

##### showTextDialog(itemId[, text[, canWrite[, length]]])
> **Description:** N/A  
> **Parameters:** <ul><li>_itemId_ - _No description_</li><li>_text_ - _(optional)_</li><li>_canWrite_ - _(optional)_</li><li>_length_ - _(optional)_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local player = Player(...)
player:showTextDialog(2400, nil, nil, nil)
```
> [To the top](To the top)(#wiki-wrapper) **Added in version:** 1.0