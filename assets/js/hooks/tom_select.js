import TomSelect from "tom-select/dist/js/tom-select.complete.min.js";

export default {
    label_field() { return this.el.dataset.label_field},
    search_field() { return this.el.dataset.search_field},
    order_field() { return this.el.dataset.order_field},
    order_field_order() { return this.el.dataset.order_field_order},
    mounted() {
        const { options, items, max_items, search_event_name, target} = this.el.dataset;
        const view = this;
        var load_function = null;

        if (search_event_name) {
            load_function = function(query, callback) {
                if (!query.length) return callback();
                if (target) {
                    view.pushEventTo(target, search_event_name, query, (reply) => {
                        callback(reply.data);
                    });
                } else {
                    view.pushEvent(search_event_name, query, (reply) => {
                        callback(reply.data);
                    });
                }
            }
        }
        const spec = {
            "maxItems": max_items,
            "valueField": "id",
            "labelField": this.label_field(),
            "searchField": this.search_field(),
            "create": false,
            "loadThrottle": 300,
            "options": JSON.parse(options),
            "items": items.split(","),
            "sortField": {
              "field": this.order_field(),
              "direction": this.order_field_order()
            },
            load: load_function
          }
        this.tomselect = new TomSelect(this.el, spec)
    }
};