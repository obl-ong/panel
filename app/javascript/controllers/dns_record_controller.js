import { Controller } from "@hotwired/stimulus";
import { StreamActions } from "@hotwired/turbo";

/*StreamActions.insertId = function() {
  const id = this.getAttribute("id");
  if(!id) {
    throw new Error("insertId stream action invoked without an id");
  }

  // DNSimple sorts records by their ID
  // TODO: insert the element in the right place
};*/

addEventListener("turbo:before-stream-render", event => {
  const orig = event.detail.render;
  event.detail.render = function(streamElement) {
    orig(streamElement);
    // update the dns_records data-empty property if necessary
    if(streamElement.id.startsWith("record-")) {
      const records = document.getElementById("dns_records");
      records.dataset.empty = records.querySelectorAll("tbody tr").length == 0;
    }
  }
});

export default class extends Controller {
  static values = { editing: { type: Boolean, default: false } };
  
  edit() {
    this.editing = true; 
  }
  cancel() {
    this.editing = false;
    // reset form fields
  }
  delete() {    
    confirm("Are you sure you want to delete the record?");
  }

  editingValueChanged() {
    
  }
}
