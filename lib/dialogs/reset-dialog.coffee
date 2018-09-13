Dialog = require './dialog'

git = require '../git'
path = require 'path'

module.exports =
class ResetDialog extends Dialog
  @content: ->
    @div class: 'dialog', =>
      @div class: 'heading', =>
        @i class: 'icon x clickable', click: 'cancel'
        @strong 'Undo'
      @div class: 'body', =>
        @label 'Undo will erase changes since the last commit in the selected files. Are you sure?'
      @div class: 'buttons', =>
        @button class: 'active', click: 'reset', =>
          @i class: 'icon reply'
          @span 'Undo'
        @button click: 'cancel', =>
          @i class: 'icon x'
          @span 'Cancel'

  activate: ->
    return super()

  reset: ->
    @deactivate()
    @parentView.reset()
    return
