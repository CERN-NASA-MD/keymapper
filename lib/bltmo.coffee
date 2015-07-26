BltmoView = require './bltmo-view'
{CompositeDisposable} = require 'atom'

module.exports = Bltmo =
  bltmoView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @bltmoView = new BltmoView(state.bltmoViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @bltmoView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'bltmo:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @bltmoView.destroy()

  serialize: ->
    bltmoViewState: @bltmoView.serialize()

  toggle: ->
    console.log 'Bltmo was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
