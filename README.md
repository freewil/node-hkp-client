# hpk-client

Use this for searching and fetching keys from public-key servers implementing
the OpenPGP HTTP Keyserver Protocol (HKP).

[![Build Status](https://secure.travis-ci.org/freewil/node-hkp-client.png)](http://travis-ci.org/freewil/node-hkp-client)

## Search

```js
var hkp = require('hkp-client');
var keyserver = 'http://pgp.mit.edu:11371';
var search = 'torvalds@linux-foundation.org';
hkp.search(keyserver, search, function(err, results) {
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
var hkp = require('hkp-client');
var keyserver = 'http://pgp.mit.edu:11371';
var keyId = '00411886';
hkp.fetch(keyserver, keyId, function(err, pubKey) {
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
