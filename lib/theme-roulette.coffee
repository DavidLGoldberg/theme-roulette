ThemeRouletteView = require './theme-roulette-view'

module.exports =
    themeRouletteView: null
    configDefaults:
        roundLengthInSeconds: 0

    activate: (state) ->
        @themeRouletteView = new ThemeRouletteView(state.themeRouletteViewState)
        roundLength = atom.config.get 'theme-roulette.roundLengthInSeconds'
        if roundLength > 0
            setInterval =>
                @themeRouletteView.spin()
            , roundLength * 1000

    deactivate: ->
        @themeRouletteView.destroy()

    serialize: ->
        themeRouletteViewState: @themeRouletteView.serialize()
