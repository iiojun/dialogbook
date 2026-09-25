import { Controller } from "@hotwired/stimulus"
import L from "leaflet"

export default class extends Controller {
  connect() {
    this.map = L.map(this.element).setView([20, 0], 2)

    L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
      attribution: "&copy; OpenStreetMap contributors"
    }).addTo(this.map)

    const data = document.getElementById("school-sites-data")
    const sites = JSON.parse(data.textContent)

    const colors = {
      university: "#e74c3c",
      high_school: "#3498db",
      junior_high_school: "#2ecc71",
      elementary_school: "#f1c40f",
      other: "#95a5a6"
    }

    sites.forEach(site => {
      const color = colors[site.site_type] || colors.other

      const icon = L.divIcon({
        className: "school-site-marker",
        html: `
          <svg
            width="25"
            height="41"
            viewBox="0 0 25 41"
            xmlns="http://www.w3.org/2000/svg"
          >
            <path
              class="pin"
              d="M12.5 0C5.6 0 0 5.6 0 12.5
                 C0 21.9 12.5 41 12.5 41
                 S25 21.9 25 12.5
                 C25 5.6 19.4 0 12.5 0Z"
              fill="${color}"
              stroke="white"
              stroke-width="1"
            />
            <circle cx="12.5" cy="12.5" r="4" fill="white"/>
          </svg>
        `,
        iconSize: [25, 41],
        iconAnchor: [12.5, 41],
        popupAnchor: [0, -41]
      })

      L.marker([site.latitude, site.longitude], { icon })
        .addTo(this.map)
        .bindPopup(site.name)
    })
  }

  disconnect() {
    this.map?.remove()
  }
}
