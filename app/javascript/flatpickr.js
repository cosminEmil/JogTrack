import flatpickr from 'flatpickr';

document.addEventListener('turbolinks:load', () => {
  flatpickr('.datetimepicker', {
    enableTime: true,
    dateFormat: "Y-m-d H:i",
  });
});