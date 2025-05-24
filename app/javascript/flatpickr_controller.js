import flatpickr from "flatpickr";

document.addEventListener("turbo:load", () => {
  document.querySelectorAll("input[data-selected-date]").forEach((input) => {
    flatpickr(input, {
      inline: true,
      dateFormat: "Y-m-d",
      defaultDate: input.dataset.selectedDate || null,
      onChange: function (selectedDates, dateStr) {
        if (dateStr) {
          const urlParam = input.dataset.urlParam;
          const url = new URL(window.location.href);
          url.searchParams.set(urlParam, dateStr);
          window.location.href = url.toString();
        }
      }
    });
  });
});
