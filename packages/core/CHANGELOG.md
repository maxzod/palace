## 0.0.2

- remove mirrors
- support .env files (queen_env)
- add req.contentType

## 0.0.1+3

- no more `palace.use(BodyParser());` its now powered by `palace_body_parser` out of the box 🎁
- if you register to endpoint with same path end method this will throw exception and the server will not open
- rename`res.write()` to `res.send()` ✏
- more tests 🧪
- fix ✅

  - `ip` bug 🐛
  - fix `router.all()` ✔
  - fix validation errors now come within list of strings fixed for all failures 📃❌

- new 🔥
  - support exceptions , you throw and the palace will map them to responses example => `throw notFound()`;
  - local guards support 🚪💂‍♂️
  - public files guard 🌎💂‍♂️

## 0.0.1+2

- add res.created and res.ok 🆗
- fix validation type miss match now it convert types to the dto by default if possible
- add mongodb example 🗿

## 0.0.1+1

- update dependencies ⬆
- add more tests 🧪
- fix isOptional validation and null-able variables ⚔

## 0.0.1

- Initial version ⭐
