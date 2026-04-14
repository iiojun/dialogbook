import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="role"
export default class extends Controller {
  static targets = ["role", "admin", "adminRow"]

  connect() {
    this.toggle()
  }

  toggle() {
    const role = this.roleTargets.find(r => r.checked)?.value

    const isTeacher = role === "teacher"

    this.adminTarget.disabled = !isTeacher
    this.adminRowTarget.classList.toggle("is-disabled", !isTeacher)

    if (!isTeacher) {
      this.adminTarget.checked = false
    }
  }
}
