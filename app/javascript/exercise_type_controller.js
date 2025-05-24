document.addEventListener("turbo:load", () => {
  const categorySelect = document.querySelector("select[name='exercise_type_category']");
  const exerciseTypeSelect = document.querySelector("select[name='exercise[exercise_type_id]']");

  if (!categorySelect || !exerciseTypeSelect) return;

  categorySelect.addEventListener("change", () => {
    const category = categorySelect.value;

    if (!category) {
      exerciseTypeSelect.innerHTML = "<option value=''>Select Exercise Type</option>";
      return;
    }

    fetch(`/exercise_types/by_category?category=${category}`)
      .then(response => response.json())
      .then(data => {
        exerciseTypeSelect.innerHTML = "<option value=''>Select Exercise Type</option>";
        data.forEach(type => {
          const option = document.createElement("option");
          option.value = type.id;
          option.textContent = type.name;
          exerciseTypeSelect.appendChild(option);
        });
      });
  });
});
