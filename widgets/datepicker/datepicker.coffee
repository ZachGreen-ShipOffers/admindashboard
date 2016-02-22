class Dashing.Datepicker extends Dashing.Widget

  ready: ->
    $('#submit').on('click', (e) ->
      from = $('#from').val()
      to = $('#to').val()
      if (from == '' && to == '')
        console.log 'blank'
      else
        console.log 'sent'
    )
    # This is fired when the widget is done being rendered

  onData: (data) ->
    # Handle incoming data
    # You can access the html node of this widget with `@node`
    # Example: $(@node).fadeOut().fadeIn() will make the node flash each time data comes in.
