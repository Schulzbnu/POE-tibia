The Spell metatable.
[Revscriptsys interface](Revscriptsys#spell)

```Lua
local spell = Spell("incantation words")
local spell = Spell("spell name")
```
### Available methods:
[name](#name)  
[id](#id)  
[group](#group)  
[cooldown](#cooldown)  
[groupCooldown](#groupCooldown)  
[level](#level)  
[magicLevel](#magicLevel)  
[mana](#mana)  
[manaPercent](#manaPercent)  
[health](#health)  
[healthPercent](#healthPercent)  
[soul](#soul)  
[range](#range)  
[isPremium](#isPremium)  
[isEnabled](#isEnabled)  
[needTarget](#needTarget)  
[needWeapon](#needWeapon)  
[needLearn](#needLearn)  
[isSelfTarget](#isSelfTarget)  
[isBlocking](#isBlocking)  
[isAggressive](#isAggressive)  
[vocation](#vocation)  

#### only for InstantSpell:
[words](#words)  
[needDirection](#needDirection)  
[hasParams](#hasParams)  
[hasPlayerNameParam](#hasPlayerNameParam)  
[needCasterTargetOrDirection](#needCasterTargetOrDirection)  
[isBlockingWalls](#isBlockingWalls)  

#### only for RuneSpells:
[runeId](#runeId)  
[charges](#charges)  
[allowFarUse](#allowFarUse)  
[blockWalls](#blockWalls)  
[checkFloor](#checkFloor)  


***

<a name="name"/>

##### name([spell_name])
> **Description:** Get or set the spell name  
> **Parameters:** <ul><li>_(optional) spell_name_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
for _, spell in ipairs(player:getInstantSpells()) do
	print(spell:name())
end
```
> **Added in version:** 1.0