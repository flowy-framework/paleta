import { getAttributeOrThrow } from "../lib/attribute";
import TomSelect from "tom-select/dist/js/tom-select.complete.min.js";

export default {
    mounted() {
        const { options, items } = this.el.dataset;
        console.log(items.split(","));
        const spec = {
            "maxItems": null,
            "valueField": "id",
            "labelField": "name",
            "searchField": "name",
            "create": false,
            "options": JSON.parse(options),
            "items": items.split(","),
            "sortField": {
              "field": "name",
              "direction": "asc"
            }
          }
        this.tomselect = new TomSelect(this.el, spec)

        // this.handleEvent(`tomselect:${this.props.id}:init`, ({ spec }) => {
        //     // var chart = new ApexCharts(this.el, spec);
        //     // chart.render();

        //     var tomselect = new TomSelect(this.el, spec)
        // });
    }
};

function getProps(hook) {
    return {
        id: getAttributeOrThrow(hook.el, "data-id"),
    };
}