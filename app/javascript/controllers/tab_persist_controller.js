import { Controller } from "@hotwired/stimulus"
import * as bootstrap from "bootstrap"

// Connects to data-controller="tab-persist"
export default class extends Controller {
  connect() {
    this.restoreTab()
    this.rememberTab()
  }

  // 前回開いていたタブを復元
  restoreTab() {
    const key = this.storageKey()
    const lastTab = localStorage.getItem(key)
    if (lastTab) {
      const triggerEl = document.querySelector(`[data-bs-target="${lastTab}"]`)
      if (triggerEl) {
        const tab = new bootstrap.Tab(triggerEl)
        tab.show()
      }
    }
  }

  // タブをクリックしたら現在のタブを記憶
  rememberTab() {
    const key = this.storageKey()
    document.querySelectorAll('[data-bs-toggle="tab"]').forEach(el => {
      el.addEventListener('shown.bs.tab', event => {
        const target = event.target.getAttribute('data-bs-target')
        localStorage.setItem(key, target)
      })
    })
  }

  // ページごとに別キーを使う（同じサイトでタブが混ざらないように）
  storageKey() {
    return `active-tab-${window.location.pathname}`
  }
}
