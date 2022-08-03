import { LightningElement, api, track } from "lwc";
import getProfilePicture from "@salesforce/apex/dragAndDropController.getProfilePicture";
import saveAttachment from "@salesforce/apex/dragAndDropController.saveAttachment";
export default class DragAndDropLwc extends LightningElement {
  @api recordId;
  @track files;
  @api pictureSrc =
    "https://s3-us-west-1.amazonaws.com/sfdc-demo/image-placeholder.png";
  @api message = "Drag profile picture here";
  connectedCallback() {
    this.getProfilePicture();
  }
  getProfilePicture() {
    getProfilePicture({
      parentId: this.recordId
    })
      .then((result) => {
        if (result && result.Id) {
          this.pictureSrc = "/sfc/servlet.shepherd/version/download/" + result.Id;
        }
      })
      .catch((error) => {
        console.log("error in get profile: ", error);
      });
  }
  onDragOver(event) {
    event.preventDefault();
  }
  onDrop(event) {
    event.stopPropagation();
    event.preventDefault();
    event.dataTransfer.dropEffect = "copy";
    var files = event.dataTransfer.files;
    if (files.length > 1) {
      return alert("You can only upload one profile picture");
    }
    this.readFile(files[0]);
    this.files=files[0];
  }
  readFile(file) {
    if (!file) return;
    if (!file.type.match(/(image.*)/)) {
      return alert("Image file not supported");
    }
    let reader = new FileReader();
    reader.onload = this.showContent.bind(this, reader);
    reader.readAsDataURL(file);
  }
  showContent(reader) {
      let base64;
    this.error = "";
    this.pictureSrc = reader.result;
   base64 = reader.result.match(/,(.*)$/)[1];
    this.upload(this.files, base64);
  }
  upload(file, base64Data) {
    this.message = "uploadeding....";
    saveAttachment({
      parentId: this.recordId,
      fileName: file.name,
      base64Data: base64Data,
    })
      .then((result) => {
        this.message = "Drag profile picture here";
      })
      .catch((error) => {
        console.log("error in save: ", error);
      });
  }
}