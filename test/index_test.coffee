assert = require 'assert'
{search, fetch, parseData, truncateKey} = require '../src/index'

KEYSERVER = 'http://pgp.rediris.es:11371'
KEYID = '92B7E835'
SEARCH = 'bitme.com'

DATA = """
info:1:5
pub:92B7E835:1:4096:1340814909::
uid:No Reply <no-reply@bitme.com>:1340814909::
pub:14AF973B:1:4096:1338642481::
uid:BitMe Contact <contact@bitme.com>:1338642481::
"""

GET = '''
<html><head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><title>Public Key Server -- Get ``0x92b7e835 ''</title></head>
<body><h1>Public Key Server -- Get ``0x92b7e835 ''</h1>
<pre>
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: SKS 1.1.2

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
Zjc=
=VGtS
-----END PGP PUBLIC KEY BLOCK-----
</pre>
</body></html>
'''

TRUNCATED = '''
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: SKS 1.1.2

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
Zjc=
=VGtS
-----END PGP PUBLIC KEY BLOCK-----
'''

describe 'hkp-client', ->

  describe 'search()', ->
    it 'should be able to retrieve array of keys', (done) ->
      search KEYSERVER, SEARCH, (err, results) ->
        assert.ifError err
        assert.ok results.length >= 5
        done() 
        
  describe 'parseData()', ->
    it 'should be able to parseData', (done) ->
      records = parseData DATA
      expected = [
        {
          pub:
            keyId: '92B7E835'
            bits: '4096'
            time: 1340814909
          uid: 
            user: 'No Reply <no-reply@bitme.com>'
            time: 1340814909
        },
        {
          pub:
            keyId: '14AF973B'
            bits: '4096'
            time: 1338642481
          uid:
            user: 'BitMe Contact <contact@bitme.com>'
            time: 1338642481
        }
      ]
      assert.deepEqual records, expected
      done()
      
  describe 'truncateKey()', ->
    it 'should truncate key', (done) ->
      assert.equal truncateKey(GET), TRUNCATED
      done()
    
  describe 'fetch()', ->
    it 'should be able to fetch a key', (done) ->
      fetch KEYSERVER, KEYID, (err, pubKey) ->
        assert.ifError err
        assert.equal pubKey, TRUNCATED
        done()
    
