import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { text: String }

  connect() {
  }

  copy() {
    navigator.clipboard.writeText(this.textValue)
    alert("Copied!")
  }

  // trigger automatically
  click(event) {
    this.copy()
  }
}
