
# Modeled off of articles.js.coffee
$ -> 
  $('.redirect_on_click').click ->
    $('.busy').show()
    redirect_url = $(this).data("redirect-url")
    window.location.href = redirect_url

