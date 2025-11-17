https://otland.net/threads/weapons-with-advantage-vs-some-monsters.268137/#post-2588801

```xml
<!-- dragon slayer -->
<melee id="7402" level="70" unproperly="1" script="dragonslayer.lua" >
    <vocation name="Knight" />
</melee>
```

```lua
-- Normal combat damage
local combat_normal = Combat()
combat_normal:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat_normal:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
combat_normal:setFormula(COMBAT_FORMULA_SKILL, 0, 0, 1, 0)  -- normal damage

-- Combat damage against dragons
local combat_dragons = Combat()
combat_dragons:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat_dragons:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
combat_dragons:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
combat_dragons:setFormula(COMBAT_FORMULA_SKILL, 0, 0, 2, 0)  -- damage x 2


-- On use weapon
function onUseWeapon(player, variant)
    -- variant.number = target id
    -- variant.type = ?? monster type?
    local target = Monster(variant.number)
    -- Is target a monster
    if target and target:isMonster() then
        -- Does the target have "dragon" somewhere in the creature name
        if target:getName():lower():find("dragon") then
            -- Use combat_dragons combat object
            return combat_dragons:execute(player, variant)
        end
    end
    -- Use normal combat object
    return combat_normal:execute(player, variant)
end
```

wand or rod version:
```lua
-- Normal combat damage
local combat_normal = Combat()
combat_normal:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)  -- element
combat_normal:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SMALLICE) -- projectile
combat_normal:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICEAREA)

function normal_onGetFormulaValues(player, level, maglevel)
    local min =  80
    local max =  110
    return -min, -max
end
combat_normal:setCallback(CALLBACK_PARAM_SKILLVALUE, "normal_onGetFormulaValues")

-- Combat damage against dragons
local combat_dragons = Combat()
combat_dragons:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)  -- element
combat_dragons:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SMALLICE)  -- projectile
combat_dragons:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)

function dragon_onGetFormulaValues(player, level, maglevel)
    -- damage x 2
    local min = 80 * 2   
    local max = 110 * 2
    return -min, -max
end
combat_dragons:setCallback(CALLBACK_PARAM_SKILLVALUE, "dragon_onGetFormulaValues")


-- On use weapon
function onUseWeapon(player, variant)
    local target = Monster(variant.number)
    -- Is target a monster
    if target and target:isMonster() then
        -- Does the target have "dragon" somewhere in the creature name
        if target:getName():lower():find("dragon") then
            -- Use combat_dragons combat object
            return combat_dragons:execute(player, variant)
        end
    end
    -- Use normal combat object
    return combat_normal:execute(player, variant)
end
```

Weapon stuff... (TODO)
```Lua
function onUseWeapon(player, variant)
	if player:getSkull() == SKULL_BLACK then
		return false
	end

	return combat:execute(player, variant)
end
```
### Available events:
[onUseWeapon()](#onUseWeapon)  


***

<a name="onUseWeapon"/>

##### onUseWeapon()
> **Description:** N/A  
> **Parameters:** N/A  
> **Accepted return values:** N/A  
> **Example:** 
```Lua
N/A  
```
Added in version: 1.0