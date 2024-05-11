export default InfiniteScroll = {
  page() {return this.el.dataset.page;},
  total_pages() {return this.el.dataset.total_pages;},
  target() {return this.el.dataset.target;},
  loadMore(entries) {
    const target = entries[0];
    console.log(this.total_pages());
    console.log(this.page());
    if (target.isIntersecting && this.pending == this.page() && this.page() <= this.total_pages()) {
      this.pending = this.page() + 1;
      this.pushEventTo(this.target(), "load-more", {});
    }
  },
  mounted() {
    this.pending = this.page();
    this.observer = new IntersectionObserver(
      (entries) => this.loadMore(entries),
      {
        root: null, // window by default
        rootMargin: "400px",
        threshold: 0.1,
      }
    );
    this.observer.observe(this.el);
  },
  destroyed() {
    this.observer.unobserve(this.el);
  },
  updated() {
    this.pending = this.page();
  },
};