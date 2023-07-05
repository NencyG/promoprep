document.addEventListener("turbo:load", function () {
  $("#promo_company_id").on("change", function () {
    var compyid = $(this).val();
    let frame = document.querySelector("turbo-frame#promo-list");
    frame.src = '/promos?company_id='+ compyid +'&format=turbo_stream'
  });
  
  $('body').on("change",'#promo', '#promo_company_id', function () {
    var filte_option = $('#promo').val();
    var compyid = $('#promo_company_id').val();
    let frame = document.querySelector("turbo-frame#promo-list");
    frame.src = '/promos?company_id='+ compyid +'&filter_option_id=' + filte_option + '&format=turbo_stream';
  });

  $("#select_company").on("change", function () {
    var select_compyid = $(this).val();
    let data = document.querySelector("turbo-frame#filter-list");
    data.src = '/promos/new?company_id='+ select_compyid +'&format=turbo_stream'
  });
});
