#= require application

attendees = []
reserves = []
max_attendees = $('[data-event-max]').data('event-max')

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

  #------------------------
  # Adding users to Events
  #------------------------

  $('ul.attendees li').each ->
    attendees.push($(this).data('id'))

  $('ul.reserves li').each ->
    reserves.push($(this).data('id'))

  $('#save-event').on 'click', (e) ->
    $(this).attr('disabled', true)
    addUsersAndReserves()
    $('form').submit()

  $('ul.users li .user-wrapper .btn').on 'click', ->
    $(this).attr('disabled', true)
    addEventsToUsers $(this)

  $('ul.attendees li .user-wrapper .btn').on 'click', ->
    $(this).attr('disabled', true)
    addEventsToAttendees $(this)

  $('ul.reserves li .user-wrapper .btn').on 'click', ->
    $(this).attr('disabled', true)
    addEventsToReserves $(this)

  $('#event_maximum_event_attendees').val $('[data-event-max]').data('event-max')

  $('#event_maximum_event_attendees').on 'input', ->
    max_attendees = $('#event_maximum_event_attendees').val()
    unless $(this).val() == ""
      sortOutAttendeesAndReserves()

  max_attendees = $('#event_maximum_event_attendees').val()

addUser = ($el) ->
  li   = $el.parent('.user-wrapper').parent('li')
  id   = $el.parent('.user-wrapper').parent('li').data('id')
  name = $el.parent('.user-wrapper').parent('li').data('name')
  html =  "<li data-id='#{id}' data-name='#{name}'>"
  html +=   "<div class='user-wrapper'>#{name}"
  html +=     "<div class='btn btn-danger btn-inline btn-sm pull-right'>Remove</div>"
  html +=  "</div>"
  html += "</li>"
  li.remove()

  if max_attendees != undefined
    if attendees.length >= max_attendees
      reserves.push(id)
      $('ul.reserves').append(html)

      $('ul.reserves li .user-wrapper .btn').off('click').on 'click', ->
        $(this).attr('disabled', true)
        addEventsToReserves $(this)
    else
      attendees.push(id)
      $('ul.attendees').append(html)

      $('ul.attendees li .user-wrapper .btn').off('click').on 'click', ->
        $(this).attr('disabled', true)
        addEventsToAttendees $(this)
  else
    reserves.push(id)
    $('ul.reserves').append(html)

    $('ul.reserves li .user-wrapper .btn').off('click').on 'click', ->
      $(this).attr('disabled', true)
      addEventsToReserves $(this)

removeAttendee = ($el) ->
  li = $el.parent('.user-wrapper').parent('li')
  id = $el.parent('.user-wrapper').parent('li').data('id')
  name = $el.parent('.user-wrapper').parent('li').data('name')
  html =  "<li data-id='#{id}' data-name='#{name}'>"
  html +=   "<div class='user-wrapper'>#{name}"
  html +=     "<div class='btn btn-success btn-inline btn-sm pull-right'>Add</div>"
  html +=  "</div>"
  html += "</li>"
  li.remove()
  if reserves.length > 0
    reserve_li = $('ul.reserves li:last')
    reserve_id = reserve_li.data('id')
    reserve_li.remove()
    attendees.push(reserve_id)
    attendees.splice(attendees.indexOf(id), 1)
    reserves.pop()
    $('ul.users').append(html)
    $('ul.attendees').append(reserve_li)
  else
    attendees.splice(attendees.indexOf(id), 1)
    $('ul.users').append(html)

  $('ul.users li .user-wrapper .btn').off('click').on 'click', ->
    $(this).attr('disabled', true)
    addEventsToUsers $(this)

  $('ul.attendees li .user-wrapper .btn').off('click').on 'click', ->
    $(this).attr('disabled', true)
    addEventsToAttendees $(this)


removeReserve = ($el) ->
  li = $el.parent('.user-wrapper').parent('li')
  id = $el.parent('.user-wrapper').parent('li').data('id')
  name = $el.parent('.user-wrapper').parent('li').data('name')
  html =  "<li data-id='#{id}' data-name='#{name}'>"
  html +=   "<div class='user-wrapper'>#{name}"
  html +=     "<div class='btn btn-success btn-inline btn-sm pull-right'>Add</div>"
  html +=  "</div>"
  html += "</li>"
  li.remove()
  if attendees.length >= max_attendees
    reserves.splice(reserves.indexOf(id), 1)
    $('ul.users').append(html)
  else if max_attendees > attendees.length
    reserves.splice(reserves.indexOf(id), 1)
    addUser $el

addEventsToUsers = ($el) ->
  addUser $el

addEventsToAttendees = ($el) ->
  removeAttendee $el

addEventsToReserves = ($el) ->
  removeReserve $el

addUsersAndReserves = ->
  if attendees.length > 0
    for attendee in attendees
      html = "<option selected value='#{attendee}'>#{attendee}</option>"
      $('.hidden-attendees select').append(html)
  if reserves.length > 0
    for reserve in reserves
      html = "<option selected value='#{reserve}'>#{reserve}</option>"
      $('.hidden-reserves select').append(html)

sortOutAttendeesAndReserves = ->
  amount_to_remove = attendees.length - max_attendees
  if attendees.length > max_attendees and reserves.length > 0

    $($("ul.attendees li").get().reverse()).each (index, value) ->
      removeAttendee $(this).find('.user-wrapper').find('.btn')
      return false if index == ( amount_to_remove - 1 )

  else if attendees.length > max_attendees and reserves.length == 0
    $($("ul.attendees li").get().reverse()).each (index, value) ->
      removeAttendee $(this).find('.user-wrapper').find('.btn')
      return false if index == ( amount_to_remove - 1 )

  else if max_attendees > attendees.length and reserves.length > 0
    amount_to_add = max_attendees - attendees.length
    $("ul.reserves li").each (index, value) ->
      removeReserve $(this).find('.user-wrapper').find('.btn')
      return false if index == ( amount_to_add - 1 )

$(document).ready(ready)
$(document).on('page:load', ready)