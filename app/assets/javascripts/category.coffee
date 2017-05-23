$(document).on "page:change", ->
    $('.cat').click ->
        console.log("Clicked")
        alert "Clicked!"