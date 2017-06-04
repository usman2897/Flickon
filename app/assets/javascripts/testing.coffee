$(document).on "turbolinks:load", ->
  url = 'http://' + window.location.host + '/sub_categories.json'
  subcatdis=[]
  $('#item_category_id').change ->
    cat = $('#item_category_id').val()
    $.getJSON(url,(response) ->
      $.each(response, (i, sub) ->
        if `cat == sub.category_id`
          subcatdis.push({ key : sub.sub_category_id, value : sub.sub_category_name } )
      )
      $('#item_sub_category_id').empty()
      $.each(subcatdis, (key, value) ->
        $('#item_sub_category_id').append($("<option></option>").attr("value", value.key).text(value.value))
      )
      subcatdis = []
    )