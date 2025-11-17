HTTP API routes
The routes interface was added in order to allow external web application to query and mutate internal game state via a REST API. By default the REST server is started on port 7174 and is only bound to localhost. It is possible to change these via config.lua, however make sure that if you do you know what you're doing. It is recommended that you run this API behind a reverse proxy (e.g. nginx) to provide TLS and rate limiting.
### Available events:
[Authenticator:hasPermissions(session, permissions)](#AuthenticatorhasPermissions)

[Authenticator:onSessionClose()](#AuthenticatoronSessionClose)


***

<a name="AuthenticatorhasPermissions"/>

##### Authenticator:hasPermissions(session, permissions)
> **Description:** This event runs on every request to check whether a particular API sessions has access to a HTTP resource.  
> **Parameters:** 
> <ul><li>session - a table that represents the remote peer's session._</li><li>_item_ - permissions required to access the resource.</li></ul>  
> **Accepted return values:** Boolean, false for a 403 Forbidden HTTP response message, otherwise true  
>  
**Example:** 
> ```
>function Authenticator:hasPermissions(session, permissions)
>	for _, permission in pairs(permissions) do
>		if (session.permissions[permission] == nil) then
>			return false
>		end
>	end
>
>	return true
>end 
> ```

<a name="AuthenticatoronSessionClose"/>

##### Authenticator:onSessionClose(session)
> **Description:** This event runs every time a remote peer closes the connection and terminates the session.  
> **Parameters:** <ul><li>session - a table that represents the remote peer's session.</li></ul>  
> **Accepted return values:** nil  
>  
**Example:** 
> ```
>function Authenticator:onSessionClose(session)
>	session.data = nil
>end
> ```

Added in version: 1.3