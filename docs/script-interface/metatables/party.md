The Party metatable contains all of the methods that handle parties.  
Creating an instance of the Party metatable (2 options):
```Lua
local party = Party(player name)
local party = Party(player userdata)
```
### Available methods:
[addInvite(player)](#addInvite)  
[addMember(player)](#addMember)  
[disband()](#disband)  
[getInviteeCount()](#getInviteeCount)  
[getInvitees()](#getInvitees)  
[getLeader()](#getLeader)  
[getMemberCount()](#getMemberCount)  
[getMembers()](#getMembers)  
[isSharedExperienceActive()](#isSharedExperienceActive)  
[isSharedExperienceEnabled()](#isSharedExperienceEnabled)  
[removeInvite(player)](#removeInvite)  
[removeMember(player)](#removeMember)  
[setLeader(player)](#setLeader)  
[setSharedExperience(active)](#setSharedExperience)  
[shareExperience(experience)](#shareExperience)  


***

<a name="addInvite"/>

##### addInvite(player)
> **Description:** N/A  
> **Parameters:** <ul><li>_player_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local party = Party(...)
party:addInvite(some_userdata)
```
> **Added in version:** 1.0

***

<a name="addMember"/>

##### addMember(player)
> **Description:** N/A  
> **Parameters:** <ul><li>_player_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local party = Party(...)
party:addMember(some_userdata)
```
> **Added in version:** 1.0

***

<a name="disband"/>

##### disband()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local party = Party(...)
party:disband()
```
> **Added in version:** 1.0

***

<a name="getInviteeCount"/>

##### getInviteeCount()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local party = Party(...)
party:getInviteeCount()
```
> **Added in version:** 1.0

***

<a name="getInvitees"/>

##### getInvitees()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local party = Party(...)
party:getInvitees()
```
> **Added in version:** 1.0

***

<a name="getLeader"/>

##### getLeader()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local party = Party(...)
party:getLeader()
```
> **Added in version:** 1.0

***

<a name="getMemberCount"/>

##### getMemberCount()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local party = Party(...)
party:getMemberCount()
```
> **Added in version:** 1.0

***

<a name="getMembers"/>

##### getMembers()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local party = Party(...)
party:getMembers()
```
> **Added in version:** 1.0

***

<a name="isSharedExperienceActive"/>

##### isSharedExperienceActive()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local party = Party(...)
party:isSharedExperienceActive()
```
> **Added in version:** 1.0

***

<a name="isSharedExperienceEnabled"/>

##### isSharedExperienceEnabled()
> **Description:** N/A  
> **Parameters:** None  
> **Returns:** N/A  
> **Example:** 
```Lua
local party = Party(...)
party:isSharedExperienceEnabled()
```
> **Added in version:** 1.0

***

<a name="removeInvite"/>

##### removeInvite(player)
> **Description:** N/A  
> **Parameters:** <ul><li>_player_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local party = Party(...)
party:removeInvite(some_userdata)
```
> **Added in version:** 1.0

***

<a name="removeMember"/>

##### removeMember(player)
> **Description:** N/A  
> **Parameters:** <ul><li>_player_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local party = Party(...)
party:removeMember(some_userdata)
```
> **Added in version:** 1.0

***

<a name="setLeader"/>

##### setLeader(player)
> **Description:** N/A  
> **Parameters:** <ul><li>_player_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local party = Party(...)
party:setLeader(some_userdata)
```
> **Added in version:** 1.0

***

<a name="setSharedExperience"/>

##### setSharedExperience(active)
> **Description:** N/A  
> **Parameters:** <ul><li>_active_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local party = Party(...)
party:setSharedExperience(unknown)
```
> **Added in version:** 1.0

***

<a name="shareExperience"/>

##### shareExperience(experience)
> **Description:** N/A  
> **Parameters:** <ul><li>_experience_ - _No description_</li></ul>
> **Returns:** N/A  
> **Example:** 
```Lua
local party = Party(...)
party:shareExperience(100)
```
> **Added in version:** 1.0