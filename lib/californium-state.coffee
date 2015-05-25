utils = require './utils'
actions = require './actions'
{Disposable, CompositeDisposable} = require 'atom'

class EditorObserver

  constructor: ->
    @subscriptions = new CompositeDisposable
    @listening = true
    @input = ''
    @editor = atom.workspace.getActiveTextEditor()
    @editorView = atom.views.getView @editor
    @editorView.addEventListener 'keypress', (event) =>
       @handleInput(event)

  handleInput: (event) ->
    if not @listening
      return
    char = utils.CHARS[event.which]
    if @input != '' and char == '^' and @input.slice(-1) == '`'
      console.log('dfgdfgdfg')
      [num, action, func, arg] = @input.split '-'
      @input = ''
      arg = arg.slice(0, -1)
      handler = new actions.ActionHandler(@editor, num, action, arg)
      handler.doFunction(func)
      @listening = false
    else
      @input += char
      console.log(@input)
    # stop keypress event
    event.preventDefault()

class ObserverHandler

  constructor: ->
    @observers = []

#TODO fix memory leak with @observers and editor deletion
  startListening: ->
    current_editor = atom.workspace.getActiveTextEditor()
    obs = null
    for o in @observers
      if o.editor is current_editor
        obs = o
        obs.listening = true
        break
    if not obs
      obs = new EditorObserver()
      @observers.push obs

module.exports = ObserverHandler
