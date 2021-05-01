const bio_remaining_chars = () => {
  const bio_textarea = document.getElementById("request_bio");
  if (bio_textarea) {
    function refreshCounter(event) {
      const dspCounter = document.getElementById("bio-max-length");
      const max_bio_length = dspCounter.dataset.bioMaxLength;
      dspCounter.innerText = `Remaining characters: ${max_bio_length - bio_textarea.textLength} / ${max_bio_length}`;
    }

    bio_textarea.addEventListener("keyup", refreshCounter);
  }
}

export { bio_remaining_chars };