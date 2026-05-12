import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="todo"
export default class extends Controller {
  static targets = ["row"]

  static values = {
    id: Number
  }

  async toggle(event) {
    const done = event.target.checked

    if (done) {
      this.rowTarget.classList.add("done-row")
    } else {
      this.rowTarget.classList.remove("done-row")
    }

    await fetch(`/td/todos/${this.idValue}/toggle`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document
          .querySelector('meta[name="csrf-token"]')
          .content
      },
      body: JSON.stringify({
        done: done
      })
    })
  }
}
