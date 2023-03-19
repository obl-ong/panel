import { Application } from "@hotwired/stimulus"
import "@hotwired/turbo-rails"

Turbo.setProgressBarDelay(200)

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
