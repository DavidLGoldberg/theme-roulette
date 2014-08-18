ThemeRouletteView = require './theme-roulette-view'

module.exports =
    themeRouletteView: null
    configDefaults:
        roundLengthInSeconds: 0

    activate: (state) ->
        @themeRouletteView = new ThemeRouletteView(state.themeRouletteViewState)

    deactivate: ->
        @themeRouletteView.destroy()

    serialize: ->
        themeRouletteViewState: @themeRouletteView.serialize()
