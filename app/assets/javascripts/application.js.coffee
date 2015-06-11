#= require jquery
#= require jquery_ujs
#= require react
#= require react_ujs
#= require_tree .


$ ->
  linkClicked = (event) ->
    console.log(event)
    console.log(event.target)
    alert("you clicker you")

  virtualDom = React.DOM.div(
    { id: "render-me-react-please" },
    React.DOM.a(
      { href: "javascript:void(0)", onClick: linkClicked},
      "Click me"
    )
  )

  React.render(virtualDom, document.body)


