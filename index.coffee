#!/usr/bin/env coffee

program = require 'commander'
program
  .version '0.0.1'
  .option '-u, --user [user]', 'user'
  .option '-p, --project [project]', 'project'
  .option '-d, --date [date]', 'date'
  .option '-h, --hours [hours]', 'hours'
  .option '-a, --activity [activity]', 'activity'
  .parse process.argv

async = require 'async'
activityMod = require './activity'
projectMod = require './project'
timeEntryMod = require './time_entry'

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
    console.log "pjr id: #{projectId}, act id: #{activityId}"
    timeEntryMod.addTimeEntry user,
      project_id: projectId
      spent_on: spentOn
      hours: hours
      activity_id: activityId
    , (error) ->
      console.log error

logTime(program.user, program.project, program.date, program.hours, program.activity)
