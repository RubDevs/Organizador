window.PLATZI = 
init: ->
    console.log 'made with love by Ruben'
    PLATZI.misc.selectizeByScope('body')
    return
tasks:
    index:
        setup: ->
            console.log 'index page'
            return
    form:
        setup: ->
            $('.participants').on 'cocoon:before-insert', (e, insertedItem, originalEvent)) ->
                
            return 
misc:
    selectizeByScope: (selector) ->
        $(selector).find('.selectize').each (i, el) ->
            $(el).selectize()
        return
$(document).on 'turbolinks:load', ->
    PLATZI.init()