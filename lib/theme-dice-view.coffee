{View} = require 'atom'
_ = require 'lodash'

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

    if @hasParent()
      @detach()
    else
      atom.workspaceView.append(this)
      setTimeout =>
        @detach()
        console.log "Theme Dice: Rolling..."
        randomTheme = _.shuffle(atom.themes.getLoadedThemes())[0]
        atom.themes.setEnabledThemes ['atom-dark-ui', randomTheme.name]
      , 500
