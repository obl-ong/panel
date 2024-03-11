import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "dialog" ]
  connect() {
    console.log("connected")
    if (!localStorage.getItem(this.dialogTarget.id)) {
      this.dialogTarget.setAttribute("open","")
    }
  }

  close() {
    localStorage.setItem(this.dialogTarget.id, "closed")
  }
}
