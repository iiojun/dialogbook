import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "preview"]

  async show() {
    const response = await fetch("/markdown/preview", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector(
          'meta[name="csrf-token"]'
        ).content
      },
      body: JSON.stringify({
        body: this.inputTarget.value
      })
    })

    if (!response.ok) {
      console.error("Markdown preview failed:", response.status)
      return
    }

    const html = await response.text()

    console.log("Preview HTML:", html)

    this.previewTarget.innerHTML = html
  }
}
