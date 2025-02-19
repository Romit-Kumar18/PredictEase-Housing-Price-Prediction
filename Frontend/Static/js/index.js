document.getElementById('property-search').addEventListener('submit', async function(event) {
  event.preventDefault();
  
  const formData = {
      sqft: document.getElementById('sqft').value,
      bedrooms: document.getElementById('bedrooms').value,
      bathrooms: document.getElementById('bathrooms').value,
      location: document.getElementById('location').value,
      parking: document.getElementById('parking').checked,
      building_type: document.getElementById('building-type').value,
      utility: document.getElementById('utility').checked,
      street_type: document.getElementById('street-type').value
  };
  
  try {
      const response = await fetch('http://127.0.0.1:8000/predict', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(formData)
      });
      
      const result = await response.json();
      document.getElementById('predictionAmount').innerHTML = `<p>The predicted price of your property is: ₹${result.predicted_price}</p>`;
  } catch (error) {
      console.error('Error:', error);
      document.getElementById('predictionAmount').innerHTML = '<p>Error fetching prediction. Please try again.</p>';
  }
});