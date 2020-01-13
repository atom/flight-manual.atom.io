---
title: Atom update server API
---

### Atom update server API

{{#warning}}

**Warning:** This API should be considered pre-release and is subject to change.

{{/warning}}

#### Atom updates

##### Listing Atom updates

###### GET /api/updates

Atom update feed, following the format expected by [Squirrel](https://github.com/Squirrel/).

Returns:

```json
{
    "name": "0.96.0",
    "notes": "[HTML release notes]",
    "pub_date": "2014-05-19T15:52:06.000Z",
    "url": "https://www.atomxplus.com/api/updates/download"
}
```
