# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.edit-quest-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    quest_id = $(this).data('questId');
    $('form#edit-quest-'+ quest_id ).show();
    
    
