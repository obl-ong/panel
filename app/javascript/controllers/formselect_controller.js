import { Controller } from "@hotwired/stimulus";
import "selectlist";

export default class extends Controller {
  static targets = [ "select" ]

  add({ formData }) {
    console.log("hii")
    formData.append(this.selectTarget.getAttribute("name"), this.selectTarget.value)
  }

  null() {
    return null
  }
}
