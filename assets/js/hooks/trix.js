import Trix from "trix";

export default {
   endpoint() { return this.el.dataset.endpoint },
   uploadFile(file, progressCallback, successCallback) {
      const formData = this.createFormData(file)
      const csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
      const xhr = new XMLHttpRequest()
      // Send a POST request to the route previously defined in `router.ex`
      xhr.open("POST", this.endpoint(), true)
      xhr.setRequestHeader("X-CSRF-Token", csrfToken)

      xhr.upload.addEventListener("progress", function (event) {
         if (event.lengthComputable) {
            const progress = Math.round((event.loaded / event.total) * 100)
            progressCallback(progress)
         }
      })

      xhr.addEventListener("load", function (event) {
         // The sample code provides a check against a 204 HTTP status
         // However, responseText is empty for this response code, so I switched to a 201 instead.
         // It also makes sense since we are "creating" a new resource inside our content.
         if (xhr.status == 200 || xhr.status == 201) {
            // Retrieve the full path of the uploaded file from the server
            const url = xhr.responseText;
            const attributes = {
               url,
               href: `${url}?content-disposition=attachment`
            }
            successCallback(attributes);
         }
      })

      xhr.send(formData);
   },

   createFormData(file) {
      var data = new FormData()
      data.append("Content-Type", file.type)
      data.append("file", file)
      return data
   },
   uploadFileAttachment(attachment) {
      this.uploadFile(attachment.file, setProgress, setAttributes)

      function setProgress(progress) {
         attachment.setUploadProgress(progress)
      }

      function setAttributes(attributes) {
         attachment.setAttributes(attributes)
      }
   },
   removeFileAttachment(url) {
      const xhr = new XMLHttpRequest()
      const formData = new FormData()
      formData.append("key", url)
      const csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")

      xhr.open("DELETE", this.endpoint(), true)
      xhr.setRequestHeader("X-CSRF-Token", csrfToken)

      xhr.send(formData)
   },
   mounted() {
      const element = document.querySelector("trix-editor");
      const view = this;

      element.editor.element.addEventListener("trix-change", (e) => {
         this.el.dispatchEvent(new Event("change", {
            bubbles: true
         }));
      });

      // Handles behavior when inserting a file
      element.editor.element.addEventListener("trix-attachment-add", function (event) {
         if (event.attachment.file) view.uploadFileAttachment(event.attachment)
      })

      // Handle behavior when deleting a file
      element.editor.element.addEventListener("trix-attachment-remove", function (event) {
         view.removeFileAttachment(event.attachment.attachment.previewURL)
      })

      element.editor.element.addEventListener("trix-file-accept", function(event) {
         const acceptedTypes = ['image/jpeg', 'image/png']
         if (!acceptedTypes.includes(event.file.type)) {
           event.preventDefault();
           // Improve the messages shown to the user
           alert("Only support attachment of jpeg or png files")
         }
       })
   },
};