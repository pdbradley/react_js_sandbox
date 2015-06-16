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
    }

  titleChanged: (event) ->
    @setState(title: event.target.value)

  descriptionChanged: (event) ->
    @setState(description: event.target.value)

  render: ->
    DOM.form
      className: "form-horizontal"
      DOM.fieldset null,
        DOM.legend null, "New Meetup"

        formInputWithLabel
          id: "Title"
          value: @state.title
          onChange: @titleChanged
          placeholder: "Meetup title"
          labelText: "Title"

        formInputWithLabel
          id: "Description"
          value: @state.description
          onChange: @descriptionChanged
          placeholder: "Meetup description"
          labelText: "Description"
          elementType: "textarea"

createNewMeetupForm = React.createFactory(CreateNewMeetupForm)

$ ->
  React.render(
    createNewMeetupForm(),
    document.getElementById("CreateNewMeetup")
  )



