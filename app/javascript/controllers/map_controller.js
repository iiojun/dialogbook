import { Controller } from "@hotwired/stimulus"
import L from "leaflet"

export default class extends Controller {
  static targets = ["latitude", "longitude"]

  connect() {
    const lat = Number(this.latitudeTarget.value || 35.681236)
    const lng = Number(this.longitudeTarget.value || 139.767125)

    this.map = L.map(this.element).setView([lat, lng], 13)

    L.tileLayer(
      "https://tile.openstreetmap.org/{z}/{x}/{y}.png"
    ).addTo(this.map)

    this.marker = L.marker([lat, lng], {
      draggable: true
    }).addTo(this.map)

    this.marker.on("dragend", e => {
      const pos = e.target.getLatLng()
      this.latitudeTarget.value = pos.lat
      this.longitudeTarget.value = pos.lng
    })

    this.map.on("click", e => {
      this.marker.setLatLng(e.latlng)

      this.latitudeTarget.value = e.latlng.lat
      this.longitudeTarget.value = e.latlng.lng
    })
  }
}
