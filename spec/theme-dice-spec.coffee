{WorkspaceView} = require 'atom'
ThemeDice = require '../lib/theme-dice'

describe "ThemeDice", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('theme-dice')

  describe "when the theme-dice:roll event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.theme-dice')).not.toExist()

      atom.workspaceView.trigger 'theme-dice:roll'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.theme-dice')).toExist()
        atom.workspaceView.trigger 'theme-dice:roll'
        expect(atom.workspaceView.find('.theme-dice')).not.toExist()
