function setCharacterCount() {
  var character_count = 0;
  for (var i = 0; i < $('.ms-selected').length; i++) {
    // console.log($('.ms-selected')[i].textContent + " ==> " + $('.ms-selected')[i].textContent.length)
    // less one for the appended checkmark character
    character_count += $('.ms-selected')[i].textContent.length - 1;
  }
  $('#character_count').removeClass();
  if (character_count > 2000){
    $('#character_count').addClass('alert-danger');
  } else if (character_count > 1800){
    $('#character_count').addClass('alert-warning');
  }
  $('#character_count').text("total character count: " + character_count)
  
}

$('#quick_set_content_provider_ids').selectMultiple({

  selectableHeader: "<input type='text' class='qs1 search-input' autocomplete='off' placeholder='filter content provider list' size='40'>&nbsp;&nbsp;&nbsp;&nbsp;<span id='selected_count'></span>&nbsp;&nbsp;&nbsp;&nbsp;<span id='character_count'></span>",

  afterInit: function(ms){
    var that = this,
        // $selectableSearch = that.$selectableUl.prev(),
        $selectableSearch = $('.qs1'),
        selectableSearchString = '#'+that.$container.attr('id')+' .ms-elem-selectable';

    $('#selected_count').text($('.ms-selected').length + " selected")

    setCharacterCount();

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

    setCharacterCount();
  },

  afterDeselect: function(){
    this.qs1.cache();
    $('#selected_count').text($('.ms-selected').length + " selected")

    setCharacterCount();
  }

});


