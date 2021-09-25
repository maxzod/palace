# Features (What this package can parse)

## Query

- [ ] parse `List`s
  - [ ] 1D
  - [ ] 2D
  - [ ] 3D
- [ ] parse `Map`s
  - [ ] empty map
  - [ ] inner map
- [ ] Parse `Set`s
  - [ ] 1D
  - [ ] 2D
  - [ ] 3D

## Body

- [ ] parse files in multipart
- [ ] parse application/json
- [ ] parse form-data
- [ ] parse x-www-form-urlencoded
- [ ] parse raw json

# behaviors

- if request contentType == null ? return empty Map : parse the request body

# supported content types for the request body

- application/xml
- text/plain
- application/x-www-form-urlencoded
- multipart/form-data
