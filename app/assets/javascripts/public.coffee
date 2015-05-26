#= require application

ready = ->
  # initiate menu
  $('.menu-opener').on 'click', ->
    if $('.menu').hasClass('open')
      $('.menu').animate
        left: '-226'
        , 100, ->
          $('.menu').removeClass('open')
    else
      $('.menu').animate
        left: '0'
        , 100, ->
          $('.menu').addClass('open')

  # open the event actions
  $('#cog').on 'click', ->
    $('#event-actions .actions').toggleClass('show')

  


$(document).ready ->
  ready()
  
$(document).on 'page:load', -> 
  ready()
  