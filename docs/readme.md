# **`Queen Palace 🏰👑`**

## Core Parts

## `Request`

wrapper class around dart `HttpRequest`
mostly will be getters to ease extracting values form the `HttpRequest`

## `Response`

wrapper class around dart `HttpResponse`
will have functions ease the process of responding to the incoming requests

**if you response to the request you will be ending the request life cycle**

- in case of ending

## `PalaceRouter`

to help you set routes and the handler for each route

## `palace`

the palace file contains only one function `openGates(PalaceRouter,{port})` which takes palace router and will start server
wait for incoming requests
transforming them to Request object
find the right endpoint if not found will respond with 404
if exist will loop throw the guards and the endpoint handler then close the IO request
