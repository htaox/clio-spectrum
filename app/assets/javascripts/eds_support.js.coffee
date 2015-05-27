
# Modeled off of articles.js.coffee
$ -> 
  $('.redirect_on_click').click ->
    $('.busy').show()
    redirect_url = $(this).data("redirect-url")
    window.location.href = redirect_url

  $('.eds_dynolink').click (e) ->

    # don't follow the link...
    e.preventDefault

    original_url = $(this).attr('href')
    # alert( "original_url:" +  original_url )
    console.log( "original_url:" +  original_url )

    fulltext_url = original_url.replace(/fulltext/, 'fulltext_url')
    # alert( "fulltext_url:" +  fulltext_url  )
    console.log( "fulltext_url:" +  fulltext_url  )

    $.get(fulltext_url, (content_url) ->
      # alert( "content_url:" +  content_url  )
      console.log( "content_url:" +  content_url  )
      window.location = content_url
    )

    return false
    

