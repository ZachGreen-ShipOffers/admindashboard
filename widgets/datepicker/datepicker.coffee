class Dashing.Datepicker extends Dashing.Widget

  ready: ->
    $('#submit').on('click', (e) ->
      ids = []
      from = $('#from').val()
      to = $('#to').val()
      $.each($('div'), (idx, el) ->
        if $(el).data('id')
          ids.push $(el).data('id')
      )
      if (from == '' && to == '')
        console.log 'blank'
      else
        $.ajax({
          method: 'POST',
          url: '/res',
          data: {"from": from, "to": to, "ids": ids}
          success: (data) ->
            console.log data
        })
    )
    # This is fired when the widget is done being rendered

  onData: (data) ->
    # Handle incoming data
    # You can access the html node of this widget with `@node`
    # Example: $(@node).fadeOut().fadeIn() will make the node flash each time data comes in.
