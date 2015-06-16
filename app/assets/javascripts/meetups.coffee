DOM = React.DOM

FormInputWithLabel = React.createClass
  displayName: "FormInputWithLabel"

  getDefaultProps: ->
    elementType: "input"
    inputType: "text"

  render: ->
    DOM.div
      className: "form-group"
      DOM.label
        htmlFor: @props.id
        className: "col-lg-2 control-label"
        @props.labelText
      DOM.div
        className: "col-lg-10"
        DOM[@props.elementType]
          className: "form-control"
          placeholder: @props.placeholder
          id: @props.id
          type: @tagType()
          value: @props.value
          onChange: @props.onChange
  tagType: ->
    {
      "input": @props.inputType,
      "textarea": null
    }[@props.elementType]

formInputWithLabel = React.createFactory(FormInputWithLabel)

CreateNewMeetupForm = React.createClass
  displayName: "CreateNewMeetupForm"

  getInitialState: ->
    {
      title: ""
      description: ""
      date: new Date()
    }

  dateChanged: (newDate) ->
    @setState(date: newDate)

  fieldChanged: (fieldName, event) ->
    stateUpdate = {}
    stateUpdate[fieldName] = event.target.value
    @setState(stateUpdate)

  formSubmitted: (event) ->
    event.preventDefault()
    $.ajax
      url: "/meetups.json",
      type: "POST",
      dataType: "JSON",
      contentType: "application/json",
      processData: false,
      data: JSON.stringify({meetup: @state})

  render: ->
    DOM.form
      className: "form-horizontal"
      onSubmit: @formSubmitted

      DOM.fieldset null,
        DOM.legend null, "New Meetup"

        formInputWithLabel
          id: "Title"
          value: @state.title
          onChange: @fieldChanged.bind(null, "title")
          placeholder: "Meetup title"
          labelText: "Title"

        formInputWithLabel
          id: "Description"
          value: @state.description
          onChange: @fieldChanged.bind(null, "description")
          placeholder: "Meetup description"
          labelText: "Description"
          elementType: "textarea"

        dateWithLabel
          onChange: @dateChanged
          date: @state.date

        DOM.div
          className: "form-group"
          DOM.div
            className: "col-lg-10 col-lg-offset-2"
            DOM.button
              type: "submit"
              className: "btn btn-primary"
              "SAVE"

createNewMeetupForm = React.createFactory(CreateNewMeetupForm)

$ ->
  React.render(
    createNewMeetupForm(),
    document.getElementById("CreateNewMeetup")
  )


DateWithLabel = React.createClass
  getDefaultProps: ->
    date: new Date()
  
  #when the year changes, compose a new date and trigger the
  #onChange method passed to this component
  onYearChange: (event) ->
    newDate = new Date(
      event.target.value,
      @props.date.getMonth(),
      @props.date.getDate()
    )
    @props.onChange(newDate)
  onMonthChange: (event) ->
    newDate = new Date(
      @props.date.getFullYear(),
      event.target.value,
      @props.date.getDate()
    )
    @props.onChange(newDate)

  onDateChange: (event) ->
    newDate = new Date(
      @props.date.getFullYear(),
      @props.date.getMonth(),
      event.target.value
    )
    @props.onChange(newDate)

  monthName: (monthNumberStartingFromZero) ->
    [
      "January", "February", "March", "April", "May", "June", "July",
      "August", "September", "October", "November", "December"
    ][monthNumberStartingFromZero]

  dayName: (date) ->
    dayNameStartingWithSundayZero = new Date(
      @props.date.getFullYear(),
      @props.date.getMonth(),
      date
    ).getDay()
    [
      "Sunday", "Monday", "Tuesday", "Wednesday",
      "Thursday", "Friday", "Saturday"
    ][dayNameStartingWithSundayZero]

  render: ->
    DOM.div
      className: "form-group"
      DOM.label
        className: "col-lg-2 control-label"
        "Date"
      DOM.div
        className: "col-lg-2"
        DOM.select
          className: "form-control"
          onChange: @onYearChange
          value: @props.date.getFullYear()
          DOM.option(value: year, key: year, year) for year in [2015..2020]
      DOM.div
        className: "col-lg-3"
        DOM.select
          className: "form-control"
          onChange: @onMonthChange
          value: @props.date.getMonth()
          DOM.option(value: month, key: month,
            "#{month+1}-#{@monthName(month)}") for month in [0..11]
      DOM.div
        className: "col-lg-2"
        DOM.select
          className: "form-control"
          onChange: @onDateChange
          value: @props.date.getDate()
          DOM.option(value: date, key: date,
            "#{date}-#{@dayName(date)}") for date in [1..31]

dateWithLabel = React.createFactory(DateWithLabel)
