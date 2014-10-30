redmineClient = require './redmineClient'

projects = null
getProjects = (callback) ->
  return callback projects if projects?
  options =
    path: '/projects.json'
    resultField: 'projects'
  redmineClient.get options, (error, result) ->
    return callback error if error
    projects = result
    callback null, projects

exports.getProjectId = (projectName, callback) ->
  getProjects (error, result)->
    return callback "get projects error:#{error}" if error
    for prj in result
      if prj.identifier is projectName
        return callback null, prj.id
    callback 'not found project id'

