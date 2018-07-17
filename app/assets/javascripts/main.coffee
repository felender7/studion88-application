String::repeat = (num) ->
  new Array(Math.round(num) + 1).join this

(($) ->
  'use strict'
  # Add segments to a slider

  $.fn.addSliderSegments = ->
    @each ->
      $this = $(this)
      option = $this.slider('option')
      amount = (option.max - (option.min)) / option.step
      orientation = option.orientation
      if 'vertical' == orientation
        output = ''
        i = undefined
        console.log amount
        i = 1
        while i <= amount - 1
          output += '<div class="ui-slider-segment" style="top:' + 100 / amount * i + '%;"></div>'
          i++
        $this.prepend output
      else
        segmentGap = 100 / amount + '%'
        segment = '<div class="ui-slider-segment" style="margin-left: ' + segmentGap + ';"></div>'
        $this.prepend segment.repeat(amount - 1)
      return

  $ ->
    # Custom Selects
    if $('[data-toggle="select"]').length
      $('[data-toggle="select"]').select2()
    # Checkboxes and Radiobuttons
    $('[data-toggle="checkbox"]').radiocheck()
    $('[data-toggle="radio"]').radiocheck()
    # Tabs
    $('.nav-tabs a').on 'click', (e) ->
      e.preventDefault()
      $(this).tab 'show'
      return
    # Tooltips
    $('[data-toggle="tooltip"]').tooltip()
    # Popovers
    $('[data-toggle="popover"]').popover()
    # jQuery UI Sliders
    $slider = $('#slider')
    if $slider.length > 0
      $slider.slider(
        max: 15
        step: 6
        value: 3
        orientation: 'horizontal'
        range: 'min').addSliderSegments()
    $slider2 = $('#slider2')
    if $slider2.length > 0
      $slider2.slider(
        min: 1
        max: 5
        values: [
          3
          4
        ]
        orientation: 'horizontal'
        range: true).addSliderSegments $slider2.slider('option').max
    $slider3 = $('#slider3')
    slider3ValueMultiplier = 100
    slider3Options = undefined
    if $slider3.length > 0
      $slider3.slider
        min: 1
        max: 5
        values: [
          3
          4
        ]
        orientation: 'horizontal'
        range: true
        slide: (event, ui) ->
          $slider3.find('.ui-slider-value:first').text('$' + ui.values[0] * slider3ValueMultiplier).end().find('.ui-slider-value:last').text '$' + ui.values[1] * slider3ValueMultiplier
          return
      slider3Options = $slider3.slider('option')
      $slider3.addSliderSegments(slider3Options.max).find('.ui-slider-value:first').text('$' + slider3Options.values[0] * slider3ValueMultiplier).end().find('.ui-slider-value:last').text '$' + slider3Options.values[1] * slider3ValueMultiplier
    $verticalSlider = $('#vertical-slider')
    if $verticalSlider.length
      $verticalSlider.slider(
        min: 1
        max: 5
        value: 3
        orientation: 'vertical'
        range: 'min').addSliderSegments $verticalSlider.slider('option').max, 'vertical'
    # Add style class name to a tooltips
    $('.tooltip').addClass ->
      if $(this).prev().attr('data-tooltip-style')
        return 'tooltip-' + $(this).prev().attr('data-tooltip-style')
      return
    # Placeholders for input/textarea
    $(':text, textarea').placeholder()
    # Make pagination demo work
    $('.pagination').on 'click', 'a', ->
      $(this).parent().siblings('li').removeClass('active').end().addClass 'active'
      return
    $('.btn-group').on 'click', 'a', ->
      $(this).siblings().removeClass('active').end().addClass 'active'
      return
    # Disable link clicks to prevent page scrolling
    $(document).on 'click', 'a[href="#fakelink"]', (e) ->
      e.preventDefault()
      return
    # jQuery UI Spinner
    $.widget 'ui.customspinner', $.ui.spinner,
      widgetEventPrefix: $.ui.spinner::widgetEventPrefix
      _buttonHtml: ->
        # Remove arrows on the buttons
        '' + '<a class="ui-spinner-button ui-spinner-up ui-corner-tr">' + '<span class="ui-icon ' + @options.icons.up + '"></span>' + '</a>' + '<a class="ui-spinner-button ui-spinner-down ui-corner-br">' + '<span class="ui-icon ' + @options.icons.down + '"></span>' + '</a>'
    $('#spinner-01, #spinner-02, #spinner-03, #spinner-04, #spinner-05').customspinner(
      min: -99
      max: 99).on('focus', ->
      $(this).closest('.ui-spinner').addClass 'focus'
      return
    ).on 'blur', ->
      $(this).closest('.ui-spinner').removeClass 'focus'
      return
    # Focus state for append/prepend inputs
    $('.input-group:not(.fileinput)').on('focus', '.form-control', ->
      $(this).closest('.input-group, .form-group').addClass 'focus'
      return
    ).on 'blur', '.form-control', ->
      $(this).closest('.input-group, .form-group').removeClass 'focus'
      return
    # Table: Toggle all checkboxes
    $('.table .toggle-all :checkbox').on 'click', ->
      $this = $(this)
      ch = $this.prop('checked')
      $this.closest('.table').find('tbody :checkbox').radiocheck if !ch then 'uncheck' else 'check'
      return
    # Table: Add class row selected
    $('.table tbody :checkbox').on 'change.radiocheck', ->
      $this = $(this)
      check = $this.prop('checked')
      checkboxes = $this.closest('.table').find('tbody :checkbox')
      checkAll = checkboxes.length == checkboxes.filter(':checked').length
      $this.closest('tr')[if check then 'addClass' else 'removeClass'] 'selected-row'
      $this.closest('.table').find('.toggle-all :checkbox').radiocheck if checkAll then 'check' else 'uncheck'
      return
    # Check if device is iOS so it can use native datepicker
    if /iPad|iPhone|iPod/.test(navigator.userAgent) and !window.MSStream
      $('#datepicker-01').attr 'type', 'date'
    else
      # jQuery UI Datepicker
      datepickerSelector = $('#datepicker-01')
      datepickerSelector.datepicker(
        showOtherMonths: true
        selectOtherMonths: true
        dateFormat: 'd MM, yy'
        yearRange: '-1:+1').prev('.input-group-btn').on 'click', (e) ->
        e and e.preventDefault()
        datepickerSelector.focus()
        return
      $.extend $.datepicker, _checkOffset: (inst, offset, isFixed) ->
        offset
      # Now let's align datepicker with the prepend button
      datepickerLeft = datepickerSelector.prev('.input-group-btn').outerWidth()
      datepickerSelector.datepicker('widget').css 'margin-left': -datepickerLeft
    # Timepicker
    $('#timepicker-01').timepicker
      className: 'timepicker-primary'
      timeFormat: 'h:i A'
    # Switches
    if $('[data-toggle="switch"]').length
      $('[data-toggle="switch"]').bootstrapSwitch()
    # Typeahead
    if $('#typeahead-demo-01').length
      states = new Bloodhound(
        datumTokenizer: (d) ->
          Bloodhound.tokenizers.whitespace d.word
        queryTokenizer: Bloodhound.tokenizers.whitespace
        limit: 4
        local: [
          { word: 'Alabama' }
          { word: 'Alaska' }
          { word: 'Arizona' }
          { word: 'Arkansas' }
          { word: 'California' }
          { word: 'Colorado' }
        ])
      states.initialize()
      $('#typeahead-demo-01').typeahead null,
        name: 'states'
        displayKey: 'word'
        source: states.ttAdapter()
    # Todo list
    $('.todo').on 'click', 'li', ->
      $(this).toggleClass 'todo-done'
      return
    # make code pretty
    window.prettyPrint and prettyPrint()
    # fix dropdown in pagination on mobile
    # $(window).resize(function () {
    #   $('.pagination ul').each(function () {
    #     var $parent = $(this);
    #     $parent.find('.pagination-dropdown').each(function () {
    #       var $this = $(this);
    #       //console.log($parent.get(0).scrollWidth + " " + $parent.innerWidth() );
    #       if ($parent.get(0).scrollWidth > $parent.innerWidth()) {
    #         $this.addClass('place-in-row');
    #       } else {
    #         $this.removeClass('place-in-row');
    #       }
    #     });
    #   });
    # }).trigger('resize');
    return
  return
) jQuery
