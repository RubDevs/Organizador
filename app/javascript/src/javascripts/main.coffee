window.PLATZI = 
init: ->
    console.log 'made with love by Ruben'
    return
tasks:
    index:
        setup: ->
            console.log 'index page'
            return
$(document).on 'turbolinks:load', ->
    PLATZI.init()