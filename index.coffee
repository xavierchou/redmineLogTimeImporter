request = require 'request'
async = require 'async'
activityMod = require './activity'
projectMod = require './project'

logTime = (user, project, spentOn, hours, activity) ->
  async.parallel [
    (cb) ->
      activityMod.getActivityId activity, cb
    (cb) ->
      projectMod.getProjectId project, cb
  ], (error, result) ->
    return console.log error if error
    activityId = result[0]
    projectId = result[1]
    console.log activityId
    console.log projectId

logTime('someone', 'dcpf', '2014/11/23', 3, 'Coding')
