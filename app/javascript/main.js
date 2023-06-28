$("#promo_company_id").on("change", function () {
    var compyid = $(this).val();
    let frame = document.querySelector("turbo-frame#promo-list");
    frame.src = '/promos?company_id='+ compyid +'&format=turbo_stream'
});
