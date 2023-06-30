document.addEventListener("turbo:load", function () {
  $("#promo_company_id").on("change", function () {
    var compyid = $(this).val();
    let frame = document.querySelector("turbo-frame#promo-list");
    console.log( '/promos?company_id='+ compyid   )
    frame.src = '/promos?company_id='+ compyid +'&format=turbo_stream'
  });

  $("#select_company").on("change", function () {
    var select_compyid = $(this).val();
    let data = document.querySelector("turbo-frame#filter-list");
    data.src = '/promos/new?company_id='+ select_compyid +'&format=turbo_stream'
    console.log(select_compyid)
});
})