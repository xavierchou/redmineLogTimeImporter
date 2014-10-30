request = require 'request'
redmineClient = require './redmineClient'

activities = null
getActivities = (callback) ->
  return callback activities if activities?
  options =
    path: '/enumerations/time_entry_activities.json'
    resultField: 'time_entry_activities'
  redmineClient.get options, (error, result) ->
    return callback error if error
    activities = result
    callback null, activities

exports.getActivityId = (activityName, callback) ->
  getActivities (error, result)->
    return callback "get activities error:#{error}" if error
    for activity in result
      if activity.name is activityName
        return callback null, activity.id
    callback 'not found acitivty id'

