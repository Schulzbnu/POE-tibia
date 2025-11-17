https://github.com/otland/forgottenserver/commit/36ca28bf37615d45bda4b253ad9c2cf32a9b0dc6

https://github.com/otland/forgottenserver/pull/3027

No description available at the moment.

```lua
local outfit = Outfit(140)
-- returns: outfit = {name='Noblewoman', lookType=140, premium=1, unlocked=1}
```

```lua
local outfit = Outfit(player:getOutfit().lookType)
player:sendTextMessage(MESSAGE_INFO_DESCR, 'You are currently wearing the ' .. outfit.name .. ' outfit.')
```