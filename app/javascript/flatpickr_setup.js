import flatpickr from "flatpickr";

document.addEventListener("turbo:load", () => {
  const dateInput = document.getElementById("workout-date");

  if (dateInput) {
    flatpickr(dateInput, {
      inline: true,
      dateFormat: "Y-m-d",
      defaultDate: dateInput.dataset.selectedDate || null,
      onChange: function (selectedDates, dateStr) {
        if (dateStr) {
          window.location.href = `?performed_on=${dateStr}`;
        }
      }
    });
  }
});
