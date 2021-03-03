// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"
import { fetchWithToken } from '../utils/fetch_with_token';


export default class extends Controller {
  // static targets = [ "output" ]
  static values = { clashId: String };

  publisher() {
  	// console.log(this.clashIdValue);
    // this.outputTarget.textContent = 'Hello, Stimulus!'
    if (document.getElementById("empty-thumbs-up-publisher")) {
		fetchWithToken(`/clashes/${this.clashIdValue}/votes`, {
			method: "POST",
			headers: { 
				accept: "application/json",
				'Content-Type': "application/json"
			},
			body: JSON.stringify({party: "publisher"}) 
		})
			.then(response => response.json())
			.then((data) => {
				console.log(data);
				document.querySelector("#publisher-count").innerHTML = data.counter;
				document.querySelector("#empty-thumbs-up-publisher").classList.remove("far").add("fas")
			});
    } 
    if (document.getElementById("filled-thumbs-up-publisher")) {

    }

  }

  contender() {
    // this.outputTarget.textContent = 'Hello, Stimulus!'
	fetchWithToken(`/clashes/${this.clashIdValue}/votes`, {
		method: "POST",
		headers: { 
			accept: "application/json",
			'Content-Type': "application/json"
		},
		body: JSON.stringify({party: "contender"}) 
	})
		.then(response => response.json())
		.then((data) => {
			console.log(data);
			document.querySelector("#contender-count").innerHTML = data.counter;

		});
  }
}
