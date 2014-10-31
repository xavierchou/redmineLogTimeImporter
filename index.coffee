#!/usr/bin/env coffee

program = require 'commander'
async = require 'async'
fs = require 'fs'
csv = require 'csv'
activityMod = require './activity'
projectMod = require './project'
timeEntryMod = require './time_entry'

program
  .version '0.0.1'
  .option '-u, --user [user]', 'user'
  .option '-p, --project [project]', 'project'
  .option '-d, --date [date]', 'date'
  .option '-h, --hours [hours]', 'hours'
  .option '-a, --activity [activity]', 'activity'
  .option '-f, --csvfile [csvfile]', 'import csv file'
  .parse process.argv


logTime = (user, project, spentOn, hours, activity, others...) ->
  console.log  project
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
    #timeEntryMod.addTimeEntry user,
    #  project_id: projectId
    #  spent_on: spentOn
    #  hours: hours
    #  activity_id: activityId
    #, (error) ->
    #  console.log error ? 'OK'


if program.csvfile?
  fs.readFile program.csvfile, {encoding: 'ascii'}, (err, data) ->
    return console.log "read file error: #{err}" if err
    csv.parse data, {trim: true}, (error, rows) ->
      return console.log "csv parse error: #{error}" if error
      for row in rows
        logTime row...
      console.log "finished #{rows.length} lines data"
else
  logTime(program.user, program.project, program.date, program.hours, program.activity)
  console.log 'finished'


