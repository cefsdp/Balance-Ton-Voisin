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
	static values = { clashId: String,
										votePubliId: String,
										voteContendId: String
  								};

  publisher(event) {
  	// console.log(this.clashIdValue);
    // this.outputTarget.textContent = 'Hello, Stimulus!'
    const publiThumbsUp = event.currentTarget.firstElementChild;
    const contendThumbsUp = document.getElementById("contend-thumb");

    if (publiThumbsUp.classList.contains("far")) {
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
					publiThumbsUp.classList.remove("far");
					publiThumbsUp.classList.add("fas");
					this.votePubliIdValue = data.voteId;
					if (contendThumbsUp.classList.contains("fas")) {
						contendThumbsUp.parentNode.click();
					}
				});
    }

    if (publiThumbsUp.classList.contains("fas")) {
    	console.log(this.votePubliIdValue)
    	fetchWithToken(`/votes/${this.votePubliIdValue}`, {
			method: "DELETE",
			headers: { 
					accept: "application/json",
					'Content-Type': "application/json"
				}})
				.then(response => response.json())
				.then((data) => {
					console.log(data);
					document.querySelector("#publisher-count").innerHTML = data.counter;
					publiThumbsUp.classList.remove("fas");
					publiThumbsUp.classList.add("far");
					this.votePubliIdValue = "";
				});
	  }
  }

  contender() {
    // this.outputTarget.textContent = 'Hello, Stimulus!'
		const contendThumbsUp = event.currentTarget.firstElementChild;
		const publiThumbsUp = document.getElementById("publi-thumb");

    if (contendThumbsUp.classList.contains("far")) {
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
					contendThumbsUp.classList.remove("far");
					contendThumbsUp.classList.add("fas");
					this.voteContendIdValue = data.voteId
					if (publiThumbsUp.classList.contains("fas")) {
						console.log(publiThumbsUp)
						publiThumbsUp.parentNode.click();
					}
				});
    }

    if (contendThumbsUp.classList.contains("fas")) {
    	console.log(this.voteContendIdValue)
    	fetchWithToken(`/votes/${this.voteContendIdValue}`, {
			method: "DELETE",
			headers: { 
					accept: "application/json",
					'Content-Type': "application/json"
				}})
				.then(response => response.json())
				.then((data) => {
					console.log(data);
					document.querySelector("#contender-count").innerHTML = data.counter;
					contendThumbsUp.classList.remove("fas");
					contendThumbsUp.classList.add("far");
					this.voteContendIdValue = "";
				});
	  }
	}
}
