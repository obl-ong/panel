import { Controller } from "@hotwired/stimulus";

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
