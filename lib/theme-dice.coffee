ThemeDiceView = require './theme-dice-view'

module.exports =
    themeDiceView: null
    configDefaults:
        roundLengthInSeconds: 0

    activate: (state) ->
        @themeDiceView = new ThemeDiceView(state.themeDiceViewState)
        roundLength = atom.config.get 'theme-dice.roundLengthInSeconds'
        if roundLength > 0
            setInterval =>
                @themeDiceView.roll()
            , roundLength * 1000

    deactivate: ->
        @themeDiceView.destroy()

    serialize: ->
        themeDiceViewState: @themeDiceView.serialize()
