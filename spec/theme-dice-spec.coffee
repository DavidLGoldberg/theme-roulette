{WorkspaceView} = require 'atom'
ThemeRoulette = require '../lib/theme-roulette'

describe "ThemeRoulette", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('theme-roulette')

  describe "when the theme-roulette:spin event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.theme-roulette')).not.toExist()

      atom.workspaceView.trigger 'theme-roulette:spin'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.theme-roulette')).toExist()
        atom.workspaceView.trigger 'theme-roulette:spin'
        expect(atom.workspaceView.find('.theme-roulette')).not.toExist()
