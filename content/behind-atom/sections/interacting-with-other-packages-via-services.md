---
title: Interacting With Other Packages Via Services
---
### Interacting With Other Packages Via Services

Atom packages can interact with each other through versioned APIs called _services_. To provide a service, in your `package.json`, specify one or more version numbers, each paired with the name of a method on your package's main module:

```json
{
  "providedServices": {
    "my-service": {
      "description": "Does a useful thing",
      "versions": {
        "1.2.3": "provideMyServiceV1",
        "2.3.4": "provideMyServiceV2"
      }
    }
  }
}
```

In your package's main module, implement the methods named above. These methods will be called any time a package is activated that consumes their corresponding service. They should return a value that implements the service's API.

```javascript
module.exports = {
  activate() {
    // ...
  },

  provideMyServiceV1() {
    return adaptToLegacyAPI(myService)
  },

  provideMyServiceV2() {
    return myService
  }
}
```

Similarly, to consume a service, specify one or more [version _ranges_](https://docs.npmjs.com/misc/semver#ranges), each paired with the name of a method on the package's main module:

```json
{
  "consumedServices": {
    "another-service": {
      "versions": {
        "^1.2.3": "consumeAnotherServiceV1",
        ">=2.3.4 <2.5": "consumeAnotherServiceV2"
      }
    }
  }
}
```

These methods will be called any time a package is activated that *provides* their corresponding service. They will receive the service object as an argument. You will usually need to perform some kind of cleanup in the event that the package providing the service is deactivated. To do this, return a `Disposable` from your service-consuming method:

```javascript
const {Disposable} = require('atom');

module.exports = {
  activate() {
    // ...
  },

  consumeAnotherServiceV1(service) {
    useService(adaptServiceFromLegacyAPI(service));
    return new Disposable(() => stopUsingService(service))
  },

  consumeAnotherServiceV2(service) {
    useService(service)
    return new Disposable(() => stopUsingService(service))
  }
}
```
