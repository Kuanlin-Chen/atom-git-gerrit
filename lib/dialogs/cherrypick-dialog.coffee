Dialog = require './dialog'

git = require '../git'

module.exports =
class CherrypickDialog extends Dialog
  @content: ->
    @div class: 'dialog', =>
      @div class: 'heading', =>
        @i class: 'icon x clickable', click: 'cancel'
        @strong 'Cherry-Pick'
      @div class: 'body', =>
        @label 'Current Branch'
        @input class: 'native-key-bindings', type: 'text', readonly: true, outlet: 'toBranch'
        @label 'Cherry-Pick From Commit'
        @input class: 'native-key-bindings', type: 'text', outlet: 'fromCommit'
      @div class: 'buttons', =>
        @button class: 'active', click: 'cherrypick', =>
          @i class: 'icon octicon-git-pull-request'
          @span 'Cherry-Pick'
        @button click: 'cancel', =>
          @i class: 'icon x'
          @span 'Cancel'

  activate: (branches) ->
    current = git.getLocalBranch()

    @toBranch.val(current)
    @fromCommit.find('option').remove()

    return super()

  cherrypick: ->
    @deactivate()
    @parentView.cherrypick(@fromCommit.val())
    return
