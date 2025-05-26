document.addEventListener("turbo:load", function () {
  const startBtn = document.getElementById("start-timer");
  const pauseBtn = document.getElementById("pause-timer");
  const resetBtn = document.getElementById("reset-timer");
  const durationInput = document.getElementById("rest-duration");
  const display = document.getElementById("timer-display");
  const beep = document.getElementById("timer-beep");

  if (!startBtn || !pauseBtn || !resetBtn || !durationInput || !display || !beep) {
    return;
  }

  let countdown;
  let remainingTime = parseInt(durationInput.value, 10);
  let defaultDuration = remainingTime;
  let isPaused = false;

  function setButtonState({ running, paused }) {
    startBtn.disabled = running && !paused;
    pauseBtn.disabled = !running || paused;
    resetBtn.disabled = !running && !paused;
  }

  function formatTime(seconds) {
    const mins = String(Math.floor(seconds / 60)).padStart(2, "0");
    const secs = String(seconds % 60).padStart(2, "0");
    return `${mins}:${secs}`;
  }

  function updateDisplay() {
    display.textContent = formatTime(remainingTime);
  }

  function startTimer() {
    if (remainingTime <= 0) return;
  
    if (isPaused) {
      isPaused = false;
      setButtonState({ running: true, paused: false });
      return;
    }
  
    if (countdown) return;
  
    isPaused = false;
    setButtonState({ running: true, paused: false });
  
    countdown = setInterval(() => {
      if (!isPaused) {
        if (remainingTime > 0) {
          remainingTime--;
          updateDisplay();
        }
  
        if (remainingTime <= 0) {
          clearInterval(countdown);
          countdown = null;

          beep.currentTime = 0;
          beep.play();
          setTimeout(() => {
            beep.pause();
            beep.currentTime = 0;
          }, 1720);

          remainingTime = defaultDuration;
          updateDisplay();
          setButtonState({ running: false, paused: false });
        }
      }
    }, 1000);
  }  

  function pauseTimer() {
    isPaused = true;
    setButtonState({ running: true, paused: true });
  }

  function resetTimer() {
    clearInterval(countdown);
    countdown = null;
    isPaused = false;
    remainingTime = parseInt(durationInput.value, 10);
    defaultDuration = remainingTime;
    updateDisplay();
    setButtonState({ running: false, paused: false });
  }

  durationInput.addEventListener("input", () => {
    remainingTime = parseInt(durationInput.value, 10) || 0;
    defaultDuration = remainingTime;
    updateDisplay();
  });

  startBtn.addEventListener("click", startTimer);
  pauseBtn.addEventListener("click", pauseTimer);
  resetBtn.addEventListener("click", resetTimer);

  updateDisplay();
  setButtonState({ running: false, paused: false });
});
