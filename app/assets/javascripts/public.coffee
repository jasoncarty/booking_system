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
  $('.calendar-event a').on 'click', ->
    $('html, body').animate({
        scrollTop: $(".flipper").offset().top - 100
    }, 600)

window.changeBookingButtons = (event_id) ->
  $("[data-event-id='#{event_id}'] [data-booking]").remove()
  button = "<a href='/events/#{event_id}/cancel' class='btn btn-red btn-center' data-remote='true' data-booking='cancel' data-event-id='#{event_id}' rel='nofollow' data-method='post'>No longer interested</a>"
  $("[data-event-id='#{event_id}'] .actions .col-sm-12").append(button)

window.changeCancelButtons = (event_id) ->
  $("[data-event-id='#{event_id}'] [data-booking]").remove()
  button = "<a href='/events/#{event_id}/book' class='btn btn-blue btn-center' data-remote='true' data-booking='book' data-event-id='#{event_id}' rel='nofollow' data-method='post'>Join in</a>"
  $("[data-event-id='#{event_id}'] .actions .col-sm-12").append(button)


window.reloadUsers = (data) ->
  eventId = data.id
  i = 0
  html = ''
  if $("[data-event-id='#{eventId}'] ul.event-attendees.not-reserves").length == 0 and data.attendees.length > 0
    html += '<h5>Attendees</h5>'
    html += "<ul class='event-attendees not-reserves'>"
  while data.attendees.length > i
    user = data.attendees[i].user
    hash = "http://www.gravatar.com/avatar/#{md5(user.email)}?s=100&d=wavatar"
    html += "<li class='event-attendee' data-attendee='#{user.id}'><img src='#{hash}' alt='#{user.name}'><span class='attendee-name'>#{user.name}</span></li>"
    i++

  if $("[data-event-id='#{eventId}'] ul.event-attendees.not-reserves").length == 0 and  data.attendees.length > 0
    html += '</ul>'
    $("[data-event-id='#{eventId}'] div.event-attendees.not-reserves").html html
  else
    $("[data-event-id='#{eventId}'] ul.event-attendees.not-reserves").html html


  i = 0
  html = ''
  if $("[data-event-id='#{eventId}'] ul.event-attendees.reserves").length == 0 and data.reserves.length > 0
    html += '<h5>Reserves</h5>'
    html += "<ul class='event-attendees reserves'>"
  while data.reserves.length > i
    user = data.reserves[i].user
    hash = "http://www.gravatar.com/avatar/#{md5(user.email)}?s=100&d=wavatar"
    html += "<li class='event-attendee' data-attendee='#{user.id}'><img src='#{hash}' alt='#{user.name}'><span class='attendee-name'>#{user.name}</span></li>"
    i++

  if $("[data-event-id='#{eventId}'] ul.event-attendees.reserves").length == 0 and data.reserves.length > 0
    html += '</ul>'
    $("[data-event-id='#{eventId}'] div.event-attendees.reserves").html html
  else
    $("[data-event-id='#{eventId}'] ul.event-attendees.reserves").html html


$(document).ready ->
  ready()

$(document).on 'page:load', ->
  ready()
