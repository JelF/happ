# support/routing manifest  
This manifest describes content of support/routing branch.
It possibly a README of a new lib, to which it would be extracted,
or just a gist to remember something.

## Terms of reference
Implement a nice routing subsystem, which allows to

* Write configuration in a nice DSL
* Implement `Route` type
* Implement `RouteSet` type, basicaly `Data.HashMap Route (ServerPart Response)`
* Implement `ToRoute` class
* [bind controllers](#controller-bindings)
* [Get path to resource from any piece of code](#link-generators)

### Controller bindings
Supposed API:  
```haskell
bindRoute :: Route -> ServerPart Response -> ServerPart Response
bindRoute "/" $ ok $ toResponse App.Views.Home.index

bindResource :: Route -> RouteSet ServerPart Response -> ServerPart Response
bindResource "news" App.Controllers.News.routes
```

### Link Generators
Supposed API:  
```haskell
let news :: News
    News.id news = 1
routeTo news -- => Route GET news 1
pathTo news -- => /news/1/

routeTo "news" -- => Route GET news
pathTo news -- => /news/
```

Laws:
```
pathTo . routeTo = pathTo
pathTo . routeTo2 = pathTo2
pathTo . routeTo3 = pathTo3
```

### Route generations
```haskell
"admin" `rc` news -- => Route GET admin news 1
"news" `rc` "create" -- => Route POST news
```
