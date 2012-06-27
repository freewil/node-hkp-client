{get} = require 'request'

parseData = (data) ->
  lines = data.split '\n'
    
  uid = null    
  pub = null
  records = []
    
  while line = lines.shift()
    fields = line.split ':'
    if fields[0] is 'pub'
      pub =
        keyId: fields[1]
        bits: fields[3]
        time: fields[4]
    else if fields[0] is 'uid'
      uid =
        user: fields[1]
        time: fields[2]
    
    # create a record once we have a pub and uid line
    if pub isnt null and uid isnt null
      records.push
        uid: uid
        pub: pub
      uid = null
      pub = null
  # end while
  
  return records
  
truncateKey = (data) ->
  data = data.replace /\r/g, ''
  lines = data.split '\n'
  begin = lines.indexOf '-----BEGIN PGP PUBLIC KEY BLOCK-----'
  if begin < 0
    throw new Error 'Unable to find beginning of public key block'
  end = lines.indexOf '-----END PGP PUBLIC KEY BLOCK-----'
  if end < 0
    throw new Error 'Unable to find end of public key block'
  key = lines.slice begin, end + 1
  return key.join '\n'
  
doRequest = (keyserver, op, search, cb) ->
  uri = "#{keyserver}/pks/lookup"
  get uri,
    qs:
      options: 'mr'
      op: op
      search: search
  , (err, res, body) ->
    return cb err if err
    if res.statusCode isnt 200
      return cb new Error "Server returned status code: #{res.statusCode}"
    cb null, body
  
search = (keyserver, search, cb) ->
  doRequest keyserver, 'index', search, (err, body) ->
    return cb err if err
    cb null, parseData body
    
fetch = (keyserver, keyId, cb) ->
  doRequest keyserver, 'get', "0x#{keyId}", (err, body) ->
    return cb err if err
    try
      key = truncateKey body
    catch e
      return cb e
    cb null, key

module.exports =
  search: search
  fetch: fetch

# allow parseData and truncateKey to be unit tested
if process.env.NODE_ENV is 'test'
  module.exports.parseData = parseData
  module.exports.truncateKey = truncateKey 
