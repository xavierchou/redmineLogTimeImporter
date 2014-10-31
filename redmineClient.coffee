request = require 'request'

config = require 'config'
serverUrl = config.serverUrl
apiKey = config.apiKey

exports.get = (options, callback) ->
  reqOptions =
    uri: serverUrl + options.path
    headers:
      'X-Redmine-API-Key': apiKey
  reqOptions.headers['X-Redmine-Switch-User'] = options.user if options.user?
  request reqOptions, (error, response, body) ->
    return callback error if error
    if response.statusCode isnt 200
      return callback "http status Not OK #{response.statusCode}"
    try
      result = JSON.parse(body)[options.resultField]
    catch e
      return callback "JSON parse error:#{e}"
    callback null, result

exports.post = (options, callback) ->
  reqOptions =
    uri: serverUrl + options.path
    method: 'POST'
    headers:
      'X-Redmine-API-Key': apiKey
    json: true
    body: options.body
  reqOptions.headers['X-Redmine-Switch-User'] = options.user if options.user?
  request reqOptions, (error, response, body) ->
    return callback error if error
    if response.statusCode isnt 201
      console.log body
      return callback "http status Not OK #{response.statusCode}"
    callback null

