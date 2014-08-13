{View} = require 'atom'
_ = require 'lodash'

spinningMessage = "Theme Roulette: Spinning..."

module.exports =
class ThemeRouletteView extends View
    @content: ->
        @div class: 'theme-roulette overlay from-top', =>
            @div spinningMessage, class: "message"

    initialize: (serializeState) ->
        atom.workspaceView.command "theme-roulette:spin", => @spin()

    # Returns an object that can be retrieved when package is activated
    serialize: ->

    # Tear down any state and detach
    destroy: ->
        @detach()

    spin: ->
        if @hasParent()
            @detach()
        else
            message = this.find '.message'
            message.html spinningMessage
            atom.workspaceView.append this
            setTimeout =>
                themeNames = atom.themes.getLoadedNames().filter (name) ->
                    !name.endsWith '-ui'
                randomThemeName = _.shuffle(themeNames)[0]
                spunMessage = "Theme Roulette: Spun #{randomThemeName}"
                console.log spunMessage
                message.html spunMessage
                atom.themes.setEnabledThemes [
                    atom.themes.getActiveNames()[1]
                    randomThemeName
                ]
                setTimeout =>
                    @detach()
                , 3500
            , 700
