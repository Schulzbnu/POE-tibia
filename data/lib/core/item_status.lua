--[[
ItemStatusConfig centraliza a configuração do sistema de status de itens
inspirado no estilo de afixos do Path of Exile. Ele separa os atributos
por tipo de item, define raridades com limites de afixos e descreve os
valores mínimos e máximos para cada tier de atributo.
]]

ItemStatusConfig = {}

ItemStatusConfig.rarities = {
  normal = { label = 'Normal', maxAttributes = 0 },
  magic = { label = 'Mágico', maxAttributes = 2 },
  rare = { label = 'Raro', maxAttributes = 4 },
  unique = { label = 'Único', maxAttributes = 6 },
  legendary = { label = 'Lendário', maxAttributes = 8 }
}

ItemStatusConfig.baseAttributes = {
  physicalDamage = {
    label = 'Dano Físico Adicional',
    tiers = {
      { tier = 1, min = 1, max = 3 },
      { tier = 2, min = 4, max = 7 },
      { tier = 3, min = 8, max = 12 },
      { tier = 4, min = 13, max = 18 }
    }
  },
  elementalDamage = {
    label = 'Dano Elemental',
    tiers = {
      { tier = 1, min = 1, max = 2 },
      { tier = 2, min = 3, max = 5 },
      { tier = 3, min = 6, max = 9 },
      { tier = 4, min = 10, max = 14 }
    }
  },
  attackSpeed = {
    label = 'Velocidade de Ataque %',
    tiers = {
      { tier = 1, min = 1, max = 2 },
      { tier = 2, min = 3, max = 5 },
      { tier = 3, min = 6, max = 8 },
      { tier = 4, min = 9, max = 12 }
    }
  },
  criticalChance = {
    label = 'Chance Crítica %',
    tiers = {
      { tier = 1, min = 5, max = 8 },
      { tier = 2, min = 9, max = 12 },
      { tier = 3, min = 13, max = 16 },
      { tier = 4, min = 17, max = 20 }
    }
  },
  maximumLife = {
    label = 'Vida Máxima',
    tiers = {
      { tier = 1, min = 5, max = 10 },
      { tier = 2, min = 11, max = 20 },
      { tier = 3, min = 21, max = 35 },
      { tier = 4, min = 36, max = 50 }
    }
  },
  maximumMana = {
    label = 'Mana Máxima',
    tiers = {
      { tier = 1, min = 8, max = 15 },
      { tier = 2, min = 16, max = 28 },
      { tier = 3, min = 29, max = 45 },
      { tier = 4, min = 46, max = 65 }
    }
  },
  physicalMitigation = {
    label = 'Redução Física %',
    tiers = {
      { tier = 1, min = 1, max = 2 },
      { tier = 2, min = 3, max = 5 },
      { tier = 3, min = 6, max = 8 },
      { tier = 4, min = 9, max = 12 }
    }
  },
  elementalResistance = {
    label = 'Resistência Elemental %',
    tiers = {
      { tier = 1, min = 3, max = 6 },
      { tier = 2, min = 7, max = 12 },
      { tier = 3, min = 13, max = 18 },
      { tier = 4, min = 19, max = 24 }
    }
  },
  movementSpeed = {
    label = 'Velocidade de Movimento %',
    tiers = {
      { tier = 1, min = 1, max = 2 },
      { tier = 2, min = 3, max = 4 },
      { tier = 3, min = 5, max = 6 },
      { tier = 4, min = 7, max = 8 }
    }
  },
  blockChance = {
    label = 'Chance de Bloqueio %',
    tiers = {
      { tier = 1, min = 1, max = 2 },
      { tier = 2, min = 3, max = 5 },
      { tier = 3, min = 6, max = 8 },
      { tier = 4, min = 9, max = 12 }
    }
  },
  armorRating = {
    label = 'Armadura',
    tiers = {
      { tier = 1, min = 10, max = 25 },
      { tier = 2, min = 26, max = 45 },
      { tier = 3, min = 46, max = 70 },
      { tier = 4, min = 71, max = 100 }
    }
  },
  spellBlock = {
    label = 'Bloqueio de Feitiços %',
    tiers = {
      { tier = 1, min = 1, max = 3 },
      { tier = 2, min = 4, max = 6 },
      { tier = 3, min = 7, max = 9 },
      { tier = 4, min = 10, max = 12 }
    }
  },
  lifeRegeneration = {
    label = 'Regeneração de Vida por Segundo',
    tiers = {
      { tier = 1, min = 1, max = 2 },
      { tier = 2, min = 3, max = 4 },
      { tier = 3, min = 5, max = 7 },
      { tier = 4, min = 8, max = 10 }
    }
  },
  manaRegeneration = {
    label = 'Regeneração de Mana por Segundo',
    tiers = {
      { tier = 1, min = 1, max = 2 },
      { tier = 2, min = 3, max = 4 },
      { tier = 3, min = 5, max = 6 },
      { tier = 4, min = 7, max = 8 }
    }
  },
  lifeLeech = {
    label = 'Roubo de Vida %',
    tiers = {
      { tier = 1, min = 1, max = 2 },
      { tier = 2, min = 3, max = 4 },
      { tier = 3, min = 5, max = 6 },
      { tier = 4, min = 7, max = 8 }
    }
  },
  manaLeech = {
    label = 'Roubo de Mana %',
    tiers = {
      { tier = 1, min = 1, max = 2 },
      { tier = 2, min = 3, max = 4 },
      { tier = 3, min = 5, max = 6 },
      { tier = 4, min = 7, max = 8 }
    }
  },
  attributeStrength = {
    label = '+ Força',
    tiers = {
      { tier = 1, min = 5, max = 8 },
      { tier = 2, min = 9, max = 14 },
      { tier = 3, min = 15, max = 20 },
      { tier = 4, min = 21, max = 28 }
    }
  },
  attributeDexterity = {
    label = '+ Destreza',
    tiers = {
      { tier = 1, min = 5, max = 8 },
      { tier = 2, min = 9, max = 14 },
      { tier = 3, min = 15, max = 20 },
      { tier = 4, min = 21, max = 28 }
    }
  },
  attributeIntelligence = {
    label = '+ Inteligência',
    tiers = {
      { tier = 1, min = 5, max = 8 },
      { tier = 2, min = 9, max = 14 },
      { tier = 3, min = 15, max = 20 },
      { tier = 4, min = 21, max = 28 }
    }
  },
  projectileDamage = {
    label = 'Dano de Projétil %',
    tiers = {
      { tier = 1, min = 3, max = 6 },
      { tier = 2, min = 7, max = 11 },
      { tier = 3, min = 12, max = 16 },
      { tier = 4, min = 17, max = 22 }
    }
  },
  mapItemRarity = {
    label = 'Raridade de Itens %',
    tiers = {
      { tier = 1, min = 5, max = 10 },
      { tier = 2, min = 11, max = 18 },
      { tier = 3, min = 19, max = 26 },
      { tier = 4, min = 27, max = 35 }
    }
  },
  mapItemQuantity = {
    label = 'Quantidade de Itens %',
    tiers = {
      { tier = 1, min = 8, max = 15 },
      { tier = 2, min = 16, max = 24 },
      { tier = 3, min = 25, max = 33 },
      { tier = 4, min = 34, max = 45 }
    }
  },
  mapMonsterDamage = {
    label = 'Dano de Monstros %',
    tiers = {
      { tier = 1, min = 4, max = 8 },
      { tier = 2, min = 9, max = 14 },
      { tier = 3, min = 15, max = 21 },
      { tier = 4, min = 22, max = 30 }
    }
  },
  mapMonsterHealth = {
    label = 'Vida dos Monstros %',
    tiers = {
      { tier = 1, min = 10, max = 18 },
      { tier = 2, min = 19, max = 28 },
      { tier = 3, min = 29, max = 40 },
      { tier = 4, min = 41, max = 55 }
    }
  },
  mapMonsterExperience = {
    label = 'Experiência de Monstros %',
    tiers = {
      { tier = 1, min = 5, max = 9 },
      { tier = 2, min = 10, max = 16 },
      { tier = 3, min = 17, max = 24 },
      { tier = 4, min = 25, max = 34 }
    }
  },
  mapMonsterQuantity = {
    label = 'Quantidade de Monstros %',
    tiers = {
      { tier = 1, min = 6, max = 12 },
      { tier = 2, min = 13, max = 20 },
      { tier = 3, min = 21, max = 29 },
      { tier = 4, min = 30, max = 40 }
    }
  }
}

ItemStatusConfig.itemTypes = {
  weapon = {
    label = 'Armas',
    attributes = { 'physicalDamage', 'elementalDamage', 'attackSpeed', 'criticalChance', 'lifeLeech', 'manaLeech' }
  },
  armor = {
    label = 'Armaduras',
    attributes = { 'maximumLife', 'maximumMana', 'physicalMitigation', 'elementalResistance', 'movementSpeed' }
  },
  shield = {
    label = 'Shield',
    attributes = { 'blockChance', 'armorRating', 'spellBlock', 'maximumLife', 'elementalResistance' }
  },
  ring = {
    label = 'Ring',
    attributes = { 'lifeRegeneration', 'manaRegeneration', 'elementalDamage', 'elementalResistance', 'attributeStrength', 'lifeLeech', 'manaLeech' }
  },
  amulet = {
    label = 'Amulet',
    attributes = { 'criticalChance', 'attackSpeed', 'attributeDexterity', 'attributeIntelligence', 'elementalDamage', 'lifeLeech', 'manaLeech' }
  },
  quiver = {
    label = 'Quiver',
    attributes = { 'projectileDamage', 'attackSpeed', 'elementalDamage' }
  },
  map = {
    label = 'Mapa',
    attributes = {
      'mapItemRarity',
      'mapItemQuantity',
      'mapMonsterDamage',
      'mapMonsterHealth',
      'mapMonsterExperience',
      'mapMonsterQuantity'
    }
  }
}

function ItemStatusConfig.getRarityConfig(rarityName)
  return ItemStatusConfig.rarities[string.lower(rarityName)]
end

function ItemStatusConfig.getMaxAttributesForRarity(rarityName)
  local rarity = ItemStatusConfig.getRarityConfig(rarityName)
  return rarity and rarity.maxAttributes or 0
end

function ItemStatusConfig.getTypeConfig(itemType)
  return ItemStatusConfig.itemTypes[string.lower(itemType)]
end

function ItemStatusConfig.getAttributesForType(itemType)
  local typeConfig = ItemStatusConfig.getTypeConfig(itemType)
  return typeConfig and typeConfig.attributes or {}
end

function ItemStatusConfig.getAttributeDefinition(attributeName)
  return ItemStatusConfig.baseAttributes[attributeName]
end

function ItemStatusConfig.getTierRange(attributeName, tier)
  local attribute = ItemStatusConfig.getAttributeDefinition(attributeName)
  if not attribute then
    return nil
  end

  for _, tierConfig in ipairs(attribute.tiers) do
    if tierConfig.tier == tier then
      return { min = tierConfig.min, max = tierConfig.max }
    end
  end
  return nil
end

local function resolveAttributeLabel(attributeName)
  local attributeDefinition = ItemStatusConfig.getAttributeDefinition(attributeName)
  return attributeDefinition and attributeDefinition.label or attributeName
end

local function formatAttributeValue(attributeName, value, tier)
  local label = resolveAttributeLabel(attributeName)

  if tier then
    local tierRange = ItemStatusConfig.getTierRange(attributeName, tier)
    if tierRange then
      return string.format("%s (Tier %d): %s [min %d - max %d]", label, tier, value, tierRange.min, tierRange.max)
    end

    return string.format("%s (Tier %d): %s", label, tier, value)
  end

  return string.format("%s: %s", label, value)
end

local function collectAttributeDescriptions(item, itemType)
  local typeConfig = ItemStatusConfig.getTypeConfig(itemType)
  if not typeConfig then
    return {}
  end

  local lines = {}
  for _, attributeName in ipairs(typeConfig.attributes) do
    local value = item:getCustomAttribute('attr_' .. attributeName)
    if value then
      local tier = item:getCustomAttribute('tier_' .. attributeName) or item:getCustomAttribute('attr_' .. attributeName .. '_tier')
      table.insert(lines, formatAttributeValue(attributeName, value, tier))
    end
  end

  return lines
end

function ItemStatusConfig.getItemStatusDescription(item)
  local rarityName = item:getCustomAttribute('rarity')
  local itemType = item:getCustomAttribute('itemType')

  if not rarityName and not itemType then
    return nil
  end

  local descriptionLines = {}

  if rarityName then
    local rarityConfig = ItemStatusConfig.getRarityConfig(rarityName) or { label = rarityName }
    table.insert(descriptionLines, string.format('Raridade: %s', rarityConfig.label))
  end

  if itemType then
    local typeConfig = ItemStatusConfig.getTypeConfig(itemType) or { label = itemType }
    table.insert(descriptionLines, string.format('Tipo de Item: %s', typeConfig.label))
  end

  local attributeLines = collectAttributeDescriptions(item, itemType)
  if #attributeLines > 0 then
    table.insert(descriptionLines, 'Atributos:')
    for _, line in ipairs(attributeLines) do
      table.insert(descriptionLines, ' - ' .. line)
    end
  end

  if #descriptionLines == 0 then
    return nil
  end

  return table.concat(descriptionLines, '\n')
end
