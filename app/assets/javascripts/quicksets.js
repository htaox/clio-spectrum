$('#quick_set_content_provider_ids').selectMultiple({

  XselectableHeader: "<span>asdfasdf</span><input type='text' class='qs1 search-input' autocomplete='off' placeholder='filter content provider list' size='40'>",
  selectableHeader: "<input type='text' class='qs1 search-input' autocomplete='off' placeholder='filter content provider list' size='40'>&nbsp;&nbsp;&nbsp;&nbsp;<span id='selected_count'></span",

  afterInit: function(ms){
    var that = this,
        // $selectableSearch = that.$selectableUl.prev(),
        $selectableSearch = $('.qs1'),
        selectableSearchString = '#'+that.$container.attr('id')+' .ms-elem-selectable';

    $('#selected_count').text($('.ms-selected').length + " selected")

    that.qs1 = $selectableSearch.quicksearch(selectableSearchString)
    .on('keydown', function(e){
      if (e.which === 40){
        that.$selectableUl.focus();
        return false;
      }
    });
  },

  afterSelect: function(){
    this.qs1.cache();
    $('#selected_count').text($('.ms-selected').length + " selected")
  },

  afterDeselect: function(){
    this.qs1.cache();
    $('#selected_count').text($('.ms-selected').length + " selected")
  }

});
