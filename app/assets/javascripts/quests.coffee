# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.edit-quest-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    quest_id = $(this).data('questId');
    $('form#edit_quest_'+ quest_id ).show()
    
    
    PrivatePub.subscribe_to '/quests', (data, channel) ->
      console.log(data)
      quest = $.parseJSON(data['quest'])
      $('.quests').append('<p>' +quest.title + '</p>')
      $('.quests').append('<p>' + quest.body + '</p>')
      $('.quests').append('<p><a href = "#">Edit</a></p>')
      $('.new_quest #answer_title').val('');
      $('.new_quest #answer_body').val('');
    
  
