import { Controller } from "@hotwired/stimulus"
import { Alert } from "bootstrap"

export default class extends Controller {
  connect() {
    this.timeout = setTimeout(() => {
      Alert.getOrCreateInstance(this.element).close()
    }, 5000)
  }

  disconnect() {
    clearTimeout(this.timeout)
  }
}
