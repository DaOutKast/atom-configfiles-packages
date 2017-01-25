{exec} = require('child_process')
Shell = require('shell')
path = require "path"
serverPath = ""

module.exports =
  activate: (state) ->
    atom.commands.add 'atom-text-editor', 'local-server-web-view:open': => @processFile()

  processFile: ->
    # Get Absolute File Path
    editor = atom.workspace.getActivePaneItem()
    file = editor?.buffer.file
    goalPath = file?.path
    # Get Relative File Path
    relativePath = atom.project.relativize(goalPath)
    # Get Associated Project URL
    projectURL = goalPath.replace(relativePath, "")
    # Personal Server URL Configuration (***EDIT YOUR CONFIGURATION HERE***)
    # serverPath is path prepended to file URL
    switch projectURL
        when "C:\\xampp\\htdocs\\franzenit\\" then (serverPath = "franzenit.localhost:8081/")
        when "C:\\xampp\\htdocs\\ThePitCrewAutomotive\\" then (serverPath = "thepitcrew.localhost:8081/")
        when "C:\\xampp\\htdocs\\SabuWorks\\" then (serverPath = "sabuworks.localhost:8081/")
        when "C:\\xampp\\htdocs\\QuizAnswers\\" then (serverPath = "quizanswers.localhost:8081/")
        when "C:\\xampp\\htdocs\\amandaConley\\" then (serverPath = "amandaconley.localhost:8081/")
        else (serverPath = "localhost:8081/")
        # EXAMPLE: when "{project_folder_path}" then (serverPath = "{prepend_url}")

    # Send Data to Print Function
    @sendToBrowser relativePath

  sendToBrowser: (relativePath) ->
      Shell.openExternal("http://"+serverPath+relativePath)
      # This creates the URL for the web browser.  EXAMPLE: "http://franzenit.localhost:8081/about.php"
