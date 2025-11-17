The scripting interface in The Forgotten Server is supported by the Lua programming language. You can customize the server with scripts for the following interfaces:
* [Action events (using items)](interfaces/actions.md)
* [Chat channel events (joining, speaking and leaving)](interfaces/chat-channel-events.md)
* [Creature events (login, logout and death)](interfaces/creature-events.md)
* [Global events (startup, shutdown, players record, timed, intervals)](interfaces/global-events.md)
* [Monster events (artificial intelligence)](interfaces/monster-events.md)
* [Movements (creature step in/out, moving items)](interfaces/movements.md)
* [NPCs (artificial intelligence)](interfaces/npcs.md)
* [Raids](interfaces/raids.md)
* [Talkactions (speaking in local chat)](interfaces/talkactions.md)
* [Spells](interfaces/spells.md)
* [Weapons](interfaces/weapons.md)

### Global
* [List of functions](global/functions.md)
* [List of constants](global/constants.md)

### Metatables
Lua does not have a class system. However, it is possible to emulate a similar system in Lua, called **Metatables**.

The script interface provides the following metatables:

* [Combat](metatables/combat.md)
* [Condition](metatables/condition.md)
* [Container](metatables/container.md)
* [Creature](metatables/creature.md)
* [Group](metatables/group.md)
* [Guild](metatables/guild.md)
* [House](metatables/house.md)
* [Item](metatables/item.md)
* [ItemType](metatables/itemtype.md)
* [ModalWindow](metatables/modalwindow.md)
* [Monster](metatables/monster.md)
* [MonsterType](metatables/monstertype.md)
* [NetworkMessage](metatables/networkmessage.md)
* [Npc](metatables/npc.md)
* [Party](metatables/party.md)
* [Player](metatables/player.md)
* [Position](metatables/position.md)
* [Teleport](metatables/teleport.md)
* [Tile](metatables/tile.md)
* [Town](metatables/town.md)
* [Variant](metatables/variant.md)
* [Vocation](metatables/vocation.md)
