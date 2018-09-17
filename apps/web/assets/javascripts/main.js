$(document).ready(function () {
  $('.nav-item.nav-link').on('click', function () {
    $('.nav-item.nav-link').removeClass('active');
    $(this).addClass('active')

    $('.nav-target').addClass('d-none');
    $($(this).data('target')).removeClass('d-none')
  });
});
