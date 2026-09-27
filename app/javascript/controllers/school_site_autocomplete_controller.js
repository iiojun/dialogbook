import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["name", "input", "hidden", "results", "submit"]
  static values = { schoolSites: Array }

  connect() {
    this.updateSubmitState()
  }

  search() {
    this.hiddenTarget.value = ""
    this.updateSubmitState()

    this.resultsTarget.innerHTML = ""

    const query = this.inputTarget.value.trim().toLowerCase()

    if (query === "") {
      return
    }

    const results = this.schoolSitesValue
      .filter(schoolSite =>
        schoolSite.name.toLowerCase().startsWith(query)
      )
      .slice(0, 10)

    results.forEach(schoolSite => {
      const item = document.createElement("button")

      item.type = "button"
      item.className = "list-group-item list-group-item-action"
      item.textContent = schoolSite.name

      item.addEventListener("click", () => {
        this.select(schoolSite)
      })

      this.resultsTarget.appendChild(item)
    })
  }

  select(schoolSite) {
    this.inputTarget.value = schoolSite.name
    this.hiddenTarget.value = schoolSite.id

    this.resultsTarget.innerHTML = ""

    this.updateSubmitState()
  }

  updateSubmitState() {
    const valid = (
      this.nameTarget.value.trim() !== "" &&
      this.hiddenTarget.value !== ""
    )
    this.submitTarget.disabled = !valid
  }
}
