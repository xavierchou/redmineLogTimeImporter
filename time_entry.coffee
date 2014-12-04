redmineClient = require './redmineClient'

exports.addTimeEntry = (user, timeEntry, callback) ->
  options =
    path: '/time_entries.json'
    body:
      time_entry: timeEntry
    user: user

  redmineClient.post options, (error) ->
    if error
      console.log error


