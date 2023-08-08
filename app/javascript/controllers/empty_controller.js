import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["empty", "watched", "toggled"];

  connect() {
    this.observer = new MutationObserver(this.update.bind(this));
    this.observer.observe(this.watchedTargets[0], {
      childList: true,
      attributes: false,
      subtree: true
    });

    this.update();
  }

  watchedTargetConnected() {
    this.observer = new MutationObserver(this.update.bind(this));
    this.observer.observe(this.watchedTargets[0], {
      childList: true,
      attributes: false,
      subtree: true
    });

    this.update();
  }

  disconnect() {
    this.observer.disconnect();
  }

  update() {
    if(this.watchedTargets[0].children.length !== 0) {
      this.emptyTargets[0].classList.add("hidden")
      this.toggledTargets[0].classList.remove("hidden")
    } else {
      this.emptyTargets[0].classList.remove("hidden")
      this.toggledTargets[0].classList.add("hidden")
    }
  }
}