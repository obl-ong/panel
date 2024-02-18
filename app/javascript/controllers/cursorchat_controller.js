import { initCursorChat } from "cursor-chat"
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    initCursorChat()
  }
}