# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $(".btn").prop("disabled", false)
  $(".museum_selection").prop("disabled", true)
  $(".museum_selection").on "change", ->
    $.ajax
      url: "/builds/storages"
      type: "GET"
      dataType: "script"
      data:
        museum_id: $('.museum_selection option:selected').val()
  $(".storage_selection").on "change", ->
    $.ajax
      url: "/builds/storage_locations"
      type: "GET"
      dataType: "script"
      data:
        storage_id: $('.storage_selection option:selected').val()
  $(".museum_selection").on "change", ->
    $.ajax
      url: "/builds/museum_prefix"
      type: "GET"
      dataType: "script"
      data:
        museum_id: $('.museum_selection option:selected').val()
        
$(document).ready(ready)
$(document).on('turbolinks:load', ready)
