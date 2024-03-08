import { getAttributeOrThrow } from "../lib/attribute";
import TomSelect from "tom-select/dist/js/tom-select.complete.min.js";

export default {
    mounted() {
        this.props = getProps(this);

        this.handleEvent(`tomselect:${this.props.id}:init`, ({ spec }) => {
            // var chart = new ApexCharts(this.el, spec);
            // chart.render();

            var tomselect = new TomSelect(this.el, spec)
        });
    }
};

function getProps(hook) {
    return {
        id: getAttributeOrThrow(hook.el, "data-id"),
    };
}