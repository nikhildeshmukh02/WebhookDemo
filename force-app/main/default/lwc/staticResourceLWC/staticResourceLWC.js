import { LightningElement } from 'lwc';
import bikeImage from '@salesforce/resourceUrl/bike_assets';
export default class StaticResourceLWC extends LightningElement {

    bikeImages = bikeImage+ '/enthusiast.png';
}