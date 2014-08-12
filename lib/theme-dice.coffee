ThemeDiceView = require './theme-dice-view'

module.exports =
  themeDiceView: null

  activate: (state) ->
    @themeDiceView = new ThemeDiceView(state.themeDiceViewState)

  deactivate: ->
    @themeDiceView.destroy()

  serialize: ->
    themeDiceViewState: @themeDiceView.serialize()
