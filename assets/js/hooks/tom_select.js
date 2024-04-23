import { getAttributeOrThrow } from "../lib/attribute";
import TomSelect from "tom-select/dist/js/tom-select.complete.min.js";

export default {
    order_field() { return this.el.dataset.order_field},
    order_field_order() { return this.el.dataset.order_field_order},
    mounted() {
        const { options, items, max_items } = this.el.dataset;
        const spec = {
            "maxItems": max_items,
            "valueField": "id",
            "labelField": "name",
            "searchField": "name",
            "create": false,
            "options": JSON.parse(options),
            "items": items.split(","),
            "sortField": {
              "field": this.order_field(),
              "direction": this.order_field_order()
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