# PoE stats overview

A coleta e aplicação das estatísticas adicionais do modo PoE ocorre dentro de `data/lib/poe_stats.lua`.

- `PoeStats.recalculate(player)` soma os modificadores nos slots definidos em `PoeItemMods.EQUIP_SLOTS` e grava os totais em storages como `PoeStats.STORAGE_CRIT_CHANCE`, `PoeStats.STORAGE_MAX_LIFE` e `PoeStats.STORAGE_MAX_MANA`.
- Regeneração, velocidade de movimento e bônus de vida/mana máxima são aplicados via `Condition` para que o cliente receba o efeito imediatamente.
- `PoeStats.sendToPlayer(player, totals)` empacota os valores calculados e envia para o opcode estendido configurado em `PoeStats.OPCODE`.

 Sempre que `poe_on_equip.lua` for acionado por um movimento de equipar ou desequipar, `PoeStats.recalculate` é chamado para manter as storages, conditions e o payload do cliente sincronizados. Ao recalcular atributos máximos, a rotina também reduz a vida/mana atuais caso tenham ficado acima do novo limite após a remoção de bônus temporários.
