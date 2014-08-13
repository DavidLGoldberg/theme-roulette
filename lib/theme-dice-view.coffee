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
                themes = atom.themes.getLoadedThemes().filter (theme) ->
                    theme.name[-3..] != '-ui'
                randomTheme = _.shuffle(themes)[0]
                spunMessage = "Theme Roulette: Spun #{randomTheme.name}"
                console.log spunMessage
                message.html spunMessage
                atom.themes.setEnabledThemes [
                    atom.config.get 'theme-roulette.defaultUi'
                    randomTheme.name
                ]
                setTimeout =>
                    @detach()
                , 3500
            , 700
