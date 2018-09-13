GitGerritView = require './git-gerrit-view'
{CompositeDisposable} = require 'atom'
git = require './git'

CMD_TOGGLE = 'git-gerrit:toggle'
EVT_SWITCH = 'pane-container:active-pane-item-changed'

views = []
view = undefined
pane = undefined
item = undefined

module.exports = GitGerrit =

  activate: (state) ->
    console.log 'GitGerrit: activate'

    atom.commands.add 'atom-workspace', CMD_TOGGLE, => @toggleView()
    atom.workspace.onDidChangeActivePaneItem (item) => @updateViews()
    atom.project.onDidChangePaths => @updatePaths()
    return

  deactivate: ->
    console.log 'GitGerrit: deactivate'
    return

  toggleView: ->
    console.log 'GitGerrit: toggle'

    unless view and view.active
      view = new GitGerritView()
      views.push view

      pane = atom.workspace.getActivePane()
      item = pane.addItem view, {index: 0}

      pane.activateItem item

    else
      pane.destroyItem item

    return

  updatePaths: ->
     git.setProjectIndex(0)
     return

  updateViews: ->
    activeView = atom.workspace.getActivePane().getActiveItem()
    for v in views when v is activeView
      v.update()
    return

  updatePaths: ->
    # when projects paths changed restart within 0
    git.setProjectIndex(0);
    return

  serialize: ->

  config:
    showGitFlowButton:
      title: 'Show GitFlow button'
      description: 'Show the GitFlow button in the Git Gerrit toolbar'
      type: 'boolean'
      default: true
    noFastForward:
      title: 'Disable Fast Forward'
      description: 'Disable Fast Forward for default at Git Merge'
      type: 'boolean'
      default: false
