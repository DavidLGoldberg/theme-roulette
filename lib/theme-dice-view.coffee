{View} = require 'atom'
_ = require 'lodash'

rollingMessage = "Theme Dice: Rolling..."

module.exports =
class ThemeDiceView extends View
    @content: ->
        @div class: 'theme-dice overlay from-top', =>
            @div rollingMessage, class: "message"

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
            message = this.find '.message'
            message.html rollingMessage
            atom.workspaceView.append this
            setTimeout =>
                themes = atom.themes.getLoadedThemes().filter (theme) ->
                    theme.name[-3..] != '-ui'
                randomTheme = _.shuffle(themes)[0]
                rolledMessage = "Theme Dice: Rolled #{randomTheme.name}"
                console.log rolledMessage
                message.html rolledMessage
                atom.themes.setEnabledThemes [
                    atom.config.get 'theme-dice.defaultUi'
                    randomTheme.name
                ]
                setTimeout =>
                    @detach()
                , 3500
            , 700
