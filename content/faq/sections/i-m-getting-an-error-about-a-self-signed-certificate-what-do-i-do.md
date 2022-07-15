---
title: I'm getting an error about a “self-signed certificate”. What do I do?
---
### I'm getting an error about a “self-signed certificate”. What do I do?

This means that there is a proxy between you and our servers where someone (typically your employer) has installed a "self-signed" security certificate in the proxy. A self-signed certificate is one that isn't trusted by anyone but the person who created the certificate. Most security certificates are backed by known, trusted and certified companies. So Atom is warning you that your connection to our servers can be snooped and even hacked by whoever created the self-signed certificate. Since it is self-signed, Atom has no way of knowing who that is.


If you decide that unsecured connections to our servers is acceptable to you, you can use the following instructions.

{{#danger}}

:rotating_light: **Danger:** If you decide that **unsecured** connections to our servers is acceptable to you, you can use the following command:

``` command-line
apm config set strict-ssl false
```

{{/danger}}
