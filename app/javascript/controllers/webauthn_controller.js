import { Controller } from "@hotwired/stimulus"
import * as Auth from "@github/webauthn-json/browser-ponyfill";
import { encode } from 'url-safe-base64'

function utf8_to_b64(str) {
  return window.btoa(unescape(encodeURIComponent(str)));
}

export default class extends Controller {
	
	static values = { options: String, csrf: String }
	
	connect() {
		console.log("hai")
	  if (typeof(PublicKeyCredential) == "undefined") {
	    window.location.pathname = "/auth/unsupported"
	  }
	}
	
	async createKey() {
		const options = Auth.parseCreationOptionsFromJSON({ publicKey: JSON.parse(this.optionsValue)});
		const response = await Auth.create(options);
		return response;
	}
	
	async createAndCut() {
		try {
			const key = await this.createKey()
			const req = await fetch("/auth/cut_key", {
				method: "PATCH",
				body: JSON.stringify(key), 
  			credentials: 'include',
				headers: {
					"X-CSRF-Token": this.csrfValue,
					"Content-Type": "application/json",
      		"Accept": "application/json"
				}
			})
			const res = await req.json()
			if(res.error) {
				throw new Error(res.error)
			}
			
			window.location.pathname = "/"
		}
		catch(e) {
			console.error(e);
		}
		
		
	}
	
	async askForKey() {
		const options = Auth.parseRequestOptionsFromJSON({ publicKey: JSON.parse(this.optionsValue)});
		const response = await Auth.get(options);
		return response.toJSON();
	}
	
	async askAndLogin() {
		try {
			const key = await this.askForKey()
			const req = await fetch("/auth/verify_key", {
				method: "POST",
  			credentials: 'include',
				body: JSON.stringify(key),
				headers: {
					"X-CSRF-Token": this.csrfValue,
					"Content-Type": "application/json",
      		"Accept": "application/json"
				}
			})
			const res = await req.json()
			if(res.error) {
				throw new Error(res.error)
			}
			
			window.location.pathname = "/"
		}
		catch(e) {
			console.error(e);
		}
		
	}
}