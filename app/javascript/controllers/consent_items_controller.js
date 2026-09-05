import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["all", "item"]

  toggleAll() {
    this.itemTargets.forEach(item => {
      item.checked = this.allTarget.checked
    })
  }

  updateAll() {
    this.allTarget.checked =
      this.itemTargets.length > 0 &&
      this.itemTargets.every(item => item.checked)
  }
}
