// Import all the channels to be used by Action Cable
import consumer from "./consumer"

// Make the consumer available globally as App.cable
window.App = window.App || {}
window.App.cable = consumer
