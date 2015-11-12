$('#quick_set_content_provider_ids').selectMultiple({
  selectableHeader: "<input type='text' class='qs1 search-input' autocomplete='off' placeholder='filter content provider list' size='40'>",
  afterInit: function(ms){
    var that = this,
        $selectableSearch = that.$selectableUl.prev(),
        selectableSearchString = '#'+that.$container.attr('id')+' .ms-elem-selectable';

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
  },
  afterDeselect: function(){
    this.qs1.cache();
  }
});
