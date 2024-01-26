import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [ "source", "button" ]

  copy() {
    navigator.clipboard.writeText(this.sourceTarget.getAttribute("value"))
    this.buttonTarget.classList.add("shaking");

    setTimeout(() => {
      this.buttonTarget.classList.remove("shaking");
    }, 820);
  }
}