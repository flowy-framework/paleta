import "./custom.js";
import ApexChartHook from "./hooks/apex_chart_hook.js";
import Editor from "./hooks/editor.js";
import GoogleMaps from "./hooks/google_maps.js";
import Pickr from "./hooks/pickr.js"
import Drag from "./hooks/drag_hook.js"
import TomSelect from "./hooks/tom_select.js"
import { TextEditor } from './hooks/quill_editor.js'


import "phoenix_html";
import { Socket } from "phoenix";
import { LiveSocket } from "phoenix_live_view";
import topbar from "../vendor/topbar.js";

let Hooks = {
  ApexChartHook,
  Editor,
  GoogleMaps,
  Pickr,
  Drag,
  TomSelect,
  TextEditor
};

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

Alpine.start();

let csrfToken = document
  .querySelector("meta[name='csrf-token']")
  .getAttribute("content");
let liveSocket = new LiveSocket("/live", Socket, {
  hooks: Hooks,
  dom: {
    // make LiveView work nicely with alpinejs
    onBeforeElUpdated(from, to) {
      if (from.__x) {
        window.Alpine.clone(from.__x, to);
      }
    },
  },
  params: {
    _csrf_token: csrfToken,
  },
});

// connect if there are any LiveViews on the page
liveSocket.connect();
// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket;
