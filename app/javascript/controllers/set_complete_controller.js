import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["checkbox"]

  toggle(event) {
    const checkbox = event.target
    const setId = checkbox.dataset.setId

    fetch(`/exercise_sets/${setId}/toggle_completed`, {
      method: "PATCH",
      headers: {
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content,
        "Content-Type": "application/json",
        "Accept": "application/json"
      }
    }).then(response => response.json())
      .then(data => {
        if (data.completed) {
          const timerStartButton = document.querySelector("#start-timer")
          if (timerStartButton) timerStartButton.click()
        }
      })
  }
}
