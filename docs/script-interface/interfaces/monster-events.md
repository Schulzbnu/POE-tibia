You can create event names in creatureevents.xml, which will link a creatureevent name to a script file located in data/creatureevents/scripts. 
You must also register events to monsters. This can either be done through the monster.xml file in data/monsters/scripts, or through Lua
```Lua
monster:registerEvent("EventNameFromCreaturescriptsXML")
```
### Available events:
[onCreatureAppear()](#onCreatureAppear)  
[onCreatureDisappear()](#onCreatureDisappear)  
[onCreatureMove()](#onCreatureMove)  
[onCreatureSay()](#onCreatureSay)  
[onThink()](#onThink)  


***

<a name="onCreatureAppear"/>

##### onCreatureAppear()
> **Description:** N/A  
> **Parameters:** N/A  
> **Accepted return values:** N/A  
> **Example:** 
```Lua
N/A  
```
Added in version: 1.0

***

<a name="onCreatureDisappear"/>

##### onCreatureDisappear()
> **Description:** N/A  
> **Parameters:** N/A  
> **Accepted return values:** N/A  
> **Example:** 
```Lua
N/A  
```
Added in version: 1.0

***

<a name="onCreatureMove"/>

##### onCreatureMove()
> **Description:** N/A  
> **Parameters:** N/A  
> **Accepted return values:** N/A  
> **Example:** 
```Lua
N/A  
```
Added in version: 1.0

***

<a name="onCreatureSay"/>

##### onCreatureSay()
> **Description:** N/A  
> **Parameters:** N/A  
> **Accepted return values:** N/A  
> **Example:** 
```Lua
N/A  
```
Added in version: 1.0

***

<a name="onThink"/>

##### onThink()
> **Description:** N/A  
> **Parameters:** N/A  
> **Accepted return values:** N/A  
> **Example:** 
```Lua
N/A  
```
Added in version: 1.0