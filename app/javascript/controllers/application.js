import { Application } from "@hotwired/stimulus"
import "chartkick/chart.js"
import "Chart.bundle"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
