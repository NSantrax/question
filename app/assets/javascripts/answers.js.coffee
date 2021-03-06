# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
  $('.edit-answer-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    answer_id = $(this).data('answerId');
    $('form#edit_answer_'+ answer_id).show()

    
    questId = $('.answers').data('questId');
    channel = '/quests/' + questId + '/answers'
    PrivatePub.subscribe_to channel, (data, channel) ->
      console.log(data)
      answer = $.parseJSON(data['answer'])
      $('.answers').append('<p>' + answer.body + '</p>')
      $('.answers').append('<p><a href = "#">Edit</a></p>')
      $('.new_answer #answer_body').val('');
    
    
  $('form.new_answer').bind 'ajax:success', (e, data, status, xhr) ->
    answer = $.parseJSON(xhr.responseText)
    $('.answers').append('<p>' + answer.body + '</p>')
    $('.answers').append('<p><a href = "#">Edit</a></p>')
    $('.new_answer #answer_body').val('');
    
  .bind 'ajax:error', (e, xhr, status, error) ->
    errors = $.parseJSON(xhr.responseText)
    $.each errors, (index, value) ->
      $('.answer-errors').append(value)
      
  $('form.edit_answer').bind 'ajax:success', (e, data, status, xhr) ->
    answer = $.parseJSON(xhr.responseText)
    $('.answers').append('<p>' + answer.body + '</p>');
    answer_id = answer.id
    $('form#edit_answer_'+ answer_id).hide();
    $('.edit-answer-link').show()
     
    
  .bind 'ajax:error', (e, xhr, status, error) ->
    errors = $.parseJSON(xhr.responseText)
    $.each errors, (index, value) ->
      $('.answer-errors').append(value)

      
   
  
