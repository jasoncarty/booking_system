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

  # initiate datepicker
  $('.datetimepicker').datetimepicker
    dateFormat: 'yy-mm-dd'

  # Initiate select2
  $('.select2').select2() 

  # Auto create event url
  $('#event_url').slugify('#event_name')

  
$(document).ready(ready)
$(document).on('page:load', ready)