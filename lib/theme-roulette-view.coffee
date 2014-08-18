{View} = require 'atom'
_ = require 'lodash'

spinningMessage = "Theme Roulette: Spinning..."

module.exports =
class ThemeRouletteView extends View
    @content: ->
        @div class: 'theme-roulette overlay from-top', =>
            @div spinningMessage, class: "message"

    @setRounds: (roundLength) ->
        clearInterval @interval if @interval?
        @interval = setInterval =>
            @spin()
        , roundLength * 1000 if roundLength?

    initialize: (serializeState) ->
        atom.workspaceView.command "theme-roulette:spin", => @spin()
        atom.workspaceView.command "theme-roulette:pause", => @pause()

        @subscribe atom.config.observe 'theme-roulette.roundLengthInSeconds',
        (roundLength) ->
            if roundLength > 0
                @roundLength = roundLength
                @setRounds @roundLength

        @state = { paused: false }

        Object.observe @state, (changes) ->
            changes.forEach (change) ->
                setRounds @roundLength if !@state.paused and @roundLength?

    # Returns an object that can be retrieved when package is activated
    serialize: ->

    # Tear down any state and detach
    destroy: ->
        @detach()

    pause: ->
        @state.paused = true
        clearInterval @interval if @interval?

    spin: ->
        @state.paused = false
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
