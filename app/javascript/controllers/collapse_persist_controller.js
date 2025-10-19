import { Controller } from "@hotwired/stimulus"
import * as bootstrap from "bootstrap"

export default class extends Controller {
  connect() {
    this.path = window.location.pathname
    this.collapses = Array.from(this.element.querySelectorAll(".collapse"))
    this.handlers = new Map()

    this.collapses.forEach(collapse => {
      const id = collapse.id
      if (!id) return

      const key = `collapse-${this.path}-${id}`
      const isOpen = localStorage.getItem(key)

      // restore status
      if (isOpen === "true") {
        const instance = bootstrap.Collapse.getOrCreateInstance(collapse, { toggle: false })
        instance.show()
      }

      // store status by watching open/close events
      const onShown = () => localStorage.setItem(key, "true")
      const onHidden = () => localStorage.setItem(key, "false")

      collapse.addEventListener("shown.bs.collapse", onShown)
      collapse.addEventListener("hidden.bs.collapse", onHidden)

      this.handlers.set(collapse, { onShown, onHidden })
    })
  }

  disconnect() {
    // clean up event listeners
    this.handlers.forEach((h, collapse) => {
      collapse.removeEventListener("shown.bs.collapse", h.onShown)
      collapse.removeEventListener("hidden.bs.collapse", h.onHidden)
    })
    this.handlers.clear()
  }
}
