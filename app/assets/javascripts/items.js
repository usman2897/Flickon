app.Items = function() {
  this._input = $('#search');
  this._initAutocomplete();
};

app.Items.prototype = {
    _initAutocomplete: function() {
    this._input
    .autocomplete({
      source: '/items',
      appendTo: '#search-results',
      select: $.proxy(this._select, this)
    })
    .autocomplete('instance')._renderItem = $.proxy(this._render, this);
    },

    _select: function(e, ui) {
        this._input.val(ui.item.item_name);
        return false;
    },

    _render: function(ul, item) {
        console.log(item);
    var markup = [
        '<span class="img">',
        '<img src="' + item.image_url + '" />',
        '</span>',
        '<span class="title">' + item.item_name + '</span>',
        '<span class="author">' + item.description + '</span>',
        '<span class="price">' + item.price + '</span>'
    ];
    return $('<li>')
        .append(markup.join(''))
        .appendTo(ul);
    }
};