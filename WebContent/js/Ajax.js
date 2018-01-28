var Ajax = function() {};

Ajax.response = function(status, error, response) {
    this.status = status;
    this.error = error;
    this.response = response;
};

Ajax.post = function (url, name, value) {
    return new Promise((resolve, reject) => {
        let xhr = new XMLHttpRequest();
        xhr.open("POST", url, true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onload = () => {
            if (xhr.status === 200)
                resolve(xhr.response);
            else
                reject(new Ajax.response(xhr.status, Error(xhr.statusText), xhr.response));
        };
        xhr.onerror = () => {
            reject(new Ajax.response(null, Error("Network error"), null));
        };
        var queryString = "";
        if ((typeof name === "object" && name.length != undefined) && (value.length === name.length)) {
        	for (let i = 0; i < name.length; i++) {
        		queryString += name[i] + "=" + encodeURIComponent(value[i]);
        		if (i !== (name.length - 1)) {
        			queryString += "&";
        		}
        	}
        	xhr.send(queryString);
        } else {
        	xhr.send(name+"="+encodeURIComponent(value));
        }
    });
};

Ajax.get = function (url) {
    return new Promise((resolve, reject) => {
        let xhr = new XMLHttpRequest();
        xhr.open("GET", url, true);
        xhr.onload = () => {
            if (xhr.status === 200)
                resolve(xhr.response);
            else
                reject(new Ajax.response(xhr.status, Error(xhr.statusText), xhr.response));
        };
        xhr.onerror = () => {
            reject(new Ajax.response(null, Error("Network error"), null));
        };
        xhr.send();
    });
}

Ajax.handleErr = function(err) {
	console.log("Got an error: ", err.error);
    if (err.status === null) {
        document.write("A network error occurred. Please check if you are connected to the network.");
        return;
    }

    let url = null;

	if (err.status === 404) {
		url = "/LepakCorner_V3/resource_not_found";
	} else {
		url = "/LepakCorner_V3/unexpected_error";
	}
	
	if (url != null) {
		Ajax.get(url).then(res => {
			document.write(res);
		}).catch(err => {
			document.write("We have encountered an unexpected error. Please try again in a few minutes.");
		});
	} else {
		console.log(err.response);
	}
};