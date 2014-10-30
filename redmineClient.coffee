request = require 'request'

serverUrl = 'http://13.187.243.104'

module.exports = (options, callback) ->
  reqOptions =
    uri: serverUrl + options.path
    headers:
      'X-Redmine-API-Key': 'xxxxxxxxxxxxxxxxxxxxxxxxx'
      'X-Redmine-Switch-User': 'xavier'
  request reqOptions, (error, response, body) ->
    return callback error if error
    if response.statusCode isnt 200
      return callback "http status Not OK #{response.statusCode}"
    try
      result = JSON.parse(body)[options.resultField]
    catch e
      return callback "JSON parse error:#{e}"
    callback null, result

