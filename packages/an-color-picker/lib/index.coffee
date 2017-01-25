pathLib      = require 'path'
fs           = require 'fs'
childProcess = require 'child_process'

module.exports =
  wordRegex: /[\#A-Za-z0-9]+/
  activate: (state) ->
    atom.commands.add 'atom-text-editor',
      'an-color-picker:show': => @open()

  deactivate: ->

  open: () ->
    editor  = atom.workspace.getActiveTextEditor()
    range   = editor.getLastCursor().getCurrentWordBufferRange({@wordRegex})
    color   = editor.getTextInBufferRange(range)
    return unless color

    command = 'python '+__dirname+'/picker.py "'+color+'"'
    childProcess.exec(command, (error, stdout, stderr) ->
      color = stdout.toString().trim()
      if color.length
        editor.setTextInBufferRange(range, color)
    )
