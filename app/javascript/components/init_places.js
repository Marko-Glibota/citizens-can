
import places from 'places.js';

const initPlaces = () => {
  const addressInput = document.querySelector('.address-input');
  if (addressInput) {
    places({ container: addressInput });
  }
};

export { initPlaces }
