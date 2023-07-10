document.addEventListener("turbo:load", function () {
  $("#promo_company_id").on("change", function () {
    var companyid = $(this).val();
    let frame = document.querySelector("turbo-frame#promo-list");
    frame.src = '/promos?company_id='+ companyid +'&format=turbo_stream'
  });

  $("#promo_company_id").on("change", function () {
    var companyid = $(this).val();
    let frame = document.querySelector("turbo-frame#filter_promo_list");
    frame.src = '/promos?company_id='+ companyid +'&format=turbo_stream'
  });
  
  $('body').on("change",'#promo', '#promo_company_id', function () {
    var filte_option = $('#promo').val();
    var companyid = $('#promo_company_id').val();
    let frame = document.querySelector("turbo-frame#promo-list");
    frame.src = '/promos?company_id='+ companyid +'&filter_option_id=' + filte_option + '&format=turbo_stream';
  });

  $("#select_company").on("change", function () {
    var select_companyid = $(this).val();
    let data = document.querySelector("turbo-frame#filter-list");
    data.src = '/promos/new?company_id='+ select_companyid +'&format=turbo_stream'
  });
});
