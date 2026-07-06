import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "button"]

  open() {
    console.log("reply-form#open")
    this.formTarget.hidden = false
    this.buttonTarget.hidden = true
  }
}
