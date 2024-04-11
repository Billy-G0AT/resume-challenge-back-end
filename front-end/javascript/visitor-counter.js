var apiUrl = "https://080sgfhfqe.execute-api.us-west-1.amazonaws.com/dev/visit-count-api";

fetch(apiUrl)
  .then(response => {
    // Checks if the request was successful (status 200)
    if (response.ok) {
      // Extracts the response as text
      return response.text();
    } 
    else {
      throw new Error('Request failed with status ' + response.status);
    }
  })
  .then(data => {
    const counter = document.getElementById('counter');
    counter.textContent = data;
  })
  .catch(error => {
    // Handles any errors that occurred during the request
    console.error('Error:', error);
  });
