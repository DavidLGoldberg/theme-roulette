{View} = require 'atom'
_ = require 'lodash'

spinningMessage = "Theme Roulette: Spinning..."

module.exports =
class ThemeRouletteView extends View
    @content: ->
        @div class: 'theme-roulette overlay from-top', =>
            @div spinningMessage, class: "message"

    setRounds: (roundLength) ->
        clearInterval @interval if @interval?
        @interval = setInterval =>
            @spin()
        , roundLength * 1000 if roundLength? and roundLength > 0

    initialize: (serializeState) ->
        atom.workspaceView.command "theme-roulette:spin", => @spin()
        atom.workspaceView.command "theme-roulette:pause", => @pause()

        @subscribe atom.config.observe 'theme-roulette.roundLengthInSeconds',
        (roundLength) =>
            @setRounds roundLength

    # Returns an object that can be retrieved when package is activated
    serialize: ->

    # Tear down any state and detach
    destroy: ->
        @detach()

    pause: ->
        clearInterval @interval if @interval?
        pausedMessage = "Theme Roulette: Paused.  Spin to unpause."
        console.log pausedMessage
        message = this.find '.message'
        message.html pausedMessage
        atom.workspaceView.append this
        setTimeout =>
            @detach()
        , 3500

    spin: ->
        @setRounds atom.config.get 'theme-roulette.roundLengthInSeconds'
        setRandomTheme = (message) ->
            themeNames = atom.themes.getLoadedNames().filter (name) ->
                !name.endsWith '-ui'
            randomThemeName = _.shuffle(themeNames)[0]
            atom.themes.setEnabledThemes [
                atom.themes.getActiveNames()[1]
                randomThemeName
            ]

            return randomThemeName

        if @hasParent()
            @detach()
        else
            message = this.find '.message'
            message.html spinningMessage
            atom.workspaceView.append this
            setTimeout =>
                spunTheme = setRandomTheme()
                spunMessage = "Theme Roulette: Spun #{spunTheme}"
                console.log spunMessage
                message.html spunMessage
                setTimeout =>
                    @detach()
                , 3500
            , 700
