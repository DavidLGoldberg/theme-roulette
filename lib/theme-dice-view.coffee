{View} = require 'atom'

module.exports =
class ThemeDiceView extends View
  @content: ->
    @div class: 'theme-dice overlay from-top', =>
      @div "Theme Dice: Rolling...", class: "message"

  initialize: (serializeState) ->
    atom.workspaceView.command "theme-dice:roll", => @roll()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  roll: ->
    console.log "Theme Dice: Rolling..."
    if @hasParent()
      @detach()
    else
      atom.workspaceView.append(this)
