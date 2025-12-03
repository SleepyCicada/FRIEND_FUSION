import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.boundToggle = this.toggle.bind(this)
    window.addEventListener("scroll", this.boundToggle)
    window.addEventListener("resize", this.boundToggle)
  }

  disconnect() {
    window.removeEventListener("scroll", this.boundToggle)
    window.removeEventListener("resize", this.boundToggle)
  }

  toggle() {
    const pageHeight = document.documentElement.scrollHeight
    const viewportHeight = window.innerHeight

    if (pageHeight > viewportHeight && window.scrollY > viewportHeight) {
      this.element.classList.add("show")
    } else {
      this.element.classList.remove("show")
    }
  }

  scrollUp() {
    window.scrollTo({ top: 0, behavior: "smooth" })
  }
}
