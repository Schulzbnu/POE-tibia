No description available at the moment.
### Available methods:

[send()](#respondersend())  
[getRequestBody()](#respondergetRequestBody())  
[setResponseBody()](#respondersetResponseBody())  
[getRequestField()](#respondergetRequestField())  
[setResponseField()](#respondersetResponseField())  
[getRequestMethod()](#respondergetRequestMethod())  
[setResponseStatus()](#respondersetResponseStatus())  
[getRequestURL()](#respondergetRequestURL())  


***

<a name="respondergetRequestBody()"/>

##### responder:getRequestBody()
> **Description:** Returns a string with the HTTP request body  
> **Parameters:** N/A  
> **Returns:** string with the request body  
> **Example:**  
```Lua
local body = responder:getRequestBody()
local request = json.decode(body)
-- Do stuff with request
```
> **Added in version:** 1.3

***

<a name="respondersend()"/>

##### responder:send()
> **Description:** Attempts to send the currently set HTTP response to the remote peer.  
> **Parameters:** N/A  
> **Returns:** N/A  
> **Example:**  
```Lua
responder:setResponseStatus(204, 'No Content')
responder:send()
return true -- By default sends are implicit, returning true from the handler means you take the responsibility of sending the response yourself.
```
> **Added in version:** 1.3

***

<a name="respondersetResponseBody()"/>

##### responder:setResponseBody(body)
> **Description:** Sets the content of the HTTP response.  
> **Parameters:** body - string containing the response content.  
> **Returns:** string with the request body  
> **Example:**  
```Lua
local body = json.encode({hello='world'})
responder:setResponseBody(body)
```
> **Added in version:** 1.3


***

<a name="respondergetRequestField()"/>

##### responder:getRequestField(fieldName)
> **Description:** Retrieves the value of the HTTP header field fieldName  
> **Parameters:** fieldName - string containing the name of the HTTP header field.  
> **Returns:** string with the HTTP field value  
> **Example:**  
```Lua
local contentType = responder:getRequestField('Content-Type')
```
> **Added in version:** 1.3

***

<a name="respondersetResponseField()"/>

##### responder:setResponseField(fieldName, fieldValue)
> **Description:** Sets the value of the HTTP header field fieldName with value fieldValue  
> **Parameters:**  
>* fieldName - string containing the name of the HTTP header field.  
>* fieldValue - string containing the value of the HTTP header field.  
> 
> **Returns:** N/A  
> **Example:**  
>```Lua
>responder:setResponseField("Content-type", "application/json")
>```
> **Added in version:** 1.3

***

<a name="respondergetRequestMethod()"/>

##### responder:getRequestMethod()
> **Description:** Retrieves the HTTP request method(e.g. GET, POST)  
> **Parameters:** N/A  
> **Returns:** string containing the HTTP request method  
> **Example:**  
>```Lua
> local method = responder:getRequestMethod()
> if (method ~= 'GET')
> 	return
> end
>```
> **Added in version:** 1.3


***


<a name="respondersetResponseStatus()"/>

##### responder:setResponseStatus(status, reason)
> **Description:** Sets the value of the HTTP header field fieldName with value fieldValue  
> **Parameters:**  
> status - number containing a RFC 7230 defined HTTP response status code.  
> fieldValue - string containing the reason for the provided status code.  
> **Returns:** N/A  
> **Example:**  
>```Lua
> responder:setResponseStatus(200, 'OK')
>```
> **Added in version:** 1.3

***

<a name="respondergetRequestURL()"/>

##### responder:getRequestURL()
> **Description:** Retrieves the HTTP request URL.  
> **Parameters:** N/A  
> **Returns:** string containing the HTTP request URL  
> **Example:**  
>```Lua
> local url = responder:getRequestMethod()
> if (url ~= '/players')
> 	return
> end
>```
> **Added in version:** 1.3


***