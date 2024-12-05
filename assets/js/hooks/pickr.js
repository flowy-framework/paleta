import flatpickr from "flatpickr";

const Pickr = {
  time_only() { return this.el.dataset.time_only == "true"},
  mounted() {
    const settings = {}

    if (this.time_only()) {
      settings.enableTime = true
      settings.noCalendar = true
      settings.dateFormat = "H:i"
    } else {
      settings.wrap = true,
      settings.altInput = this.el.dataset.pickrAltFormat ? true : false,
      settings.altFormat = this.el.dataset.pickrAltFormat || "d M Y",
      settings.dateFormat = this.el.dataset.pickrDateFormat || "m/d/Y"
    }

    this.pickr = flatpickr(this.el, settings)
  },
  updated() {
    const altFormat = this.el.dataset.pickrAltFormat
    const wasFormat = this.pickr.config.altFormat
    if (altFormat !== wasFormat) {
      this.pickr.destroy()
      this.pickr = flatpickr(this.el, {
        wrap: true,
        altInput: this.el.dataset.pickrAltFormat ? true : false,
        altFormat: this.el.dataset.pickrAltFormat || "d M Y",
        dateFormat: this.el.dataset.pickrDateFormat || "m/d/Y"
      })
    }
  },
  destroyed() {
    this.pickr.destroy()
  }
}

export default Pickr