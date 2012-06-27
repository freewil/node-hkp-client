# pks-client

Use this for searching and fetching keys from public key servers.

[![Build Status](https://secure.travis-ci.org/freewil/node-pks-client.png)](http://travis-ci.org/freewil/node-pks-client)

## Search

```js
var pks = require('pks-client');
var keyserver = 'http://pgp.mit.edu:11371';
var search = 'torvalds@linux-foundation.org';
pks.search(keyserver, search, function(err, results) {
  if (err) return console.log(err);
  console.log(results);
});
```

```
[ 
  {
    uid: { 
      user: 'Linus Torvalds <torvalds@linux-foundation.org>',
       time: '1316554898' 
    },
    pub: { 
      keyId: '00411886', 
      bits: '2048', 
      time: '1316554898'
    }
  }
]
```

## Fetch

```js
var pks = require('pks-client');
var keyserver = 'http://pgp.mit.edu:11371';
var keyId = '00411886';
pks.fetch(keyserver, keyId, function(err, pubKey) {
  if (err) return console.log(err);
  console.log(pubKey);
});
```

```
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: SKS 1.1.0

...
...

-----END PGP PUBLIC KEY BLOCK-----
```
