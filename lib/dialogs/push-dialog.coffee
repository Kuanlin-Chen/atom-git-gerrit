Dialog = require './dialog'
git = require '../git'

module.exports =
class PushDialog extends Dialog
  @content: ->
    @div class: 'dialog', =>
      @div class: 'heading', =>
        @i class: 'icon x clickable',click: 'cancel'
        @strong 'Push'
      @div class: 'body', =>
        @label 'Current branch'
        @input class: 'native-key-bindings',readonly: true,outlet: 'fromBranch'
        @label 'To branch'
        @select class: 'native-key-bindings',outlet: 'toBranch'
        @div =>
          @label 'Topic'
          @input class: 'native-key-bindings', type: 'text', outlet: 'topic'
        @div =>
          @label 'Reviewer'
          @input class: 'native-key-bindings', type: 'text', outlet: 'reviewer'
        @div =>
          @input type: 'checkbox',class: 'checkbox', outlet: 'wip'
          @label 'Work in progress'
        @div =>
          @input type: 'checkbox',class: 'checkbox', outlet: 'codereview'
          @label 'Code-Review+1'
        @div =>
          @input type: 'checkbox',class: 'checkbox', outlet: 'verified'
          @label 'Verified+1'
      @div class: 'buttons', =>
        @button class: 'active', click: 'push', =>
          @i class: 'icon push'
          @span 'Push'
        @button click: 'cancel', =>
          @i class: 'icon x'
          @span 'Cancel'

  activate: (remotes) ->
    @fromBranch.val(git.getLocalBranch())
    @toBranch.find('option').remove()

    for remote in remotes
      remote = remote.split(/\/(.+)/)[1]
      @toBranch.append "<option value='#{remote}'>#{remote}</option>"
    return super()

  push: ->
    @deactivate()
    @parentView.push(@toBranch.val(),@topic.val(),@reviewer.val(),@isWIP(),@isCodeReview(),@isVerified())
    return

  upstream: ->
    @deactivate()
    @parentView.push('','')

  isWIP: ->
     return @wip.is(':checked')

  isCodeReview: ->
     return @codereview.is(':checked')

  isVerified: ->
     return @verified.is(':checked')

