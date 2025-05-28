document.addEventListener("turbo:load", function () {
  const timerContainer = document.getElementById("rest-timer");
  const startBtn = document.getElementById("start-timer");
  const pauseBtn = document.getElementById("pause-timer");
  const resetBtn = document.getElementById("reset-timer");
  const durationInput = document.getElementById("rest-time-input");
  const display = document.getElementById("timer-display");
  const beep = document.getElementById("timer-beep");

  if (!timerContainer || !startBtn || !pauseBtn || !resetBtn || !durationInput || !display || !beep) {
    return;
  }

  const userId = timerContainer.dataset.userId;
  let restTime = parseInt(timerContainer.dataset.initialRestTime, 10) || 60;

  durationInput.value = restTime;

  let countdown;
  let remainingTime = restTime;
  let defaultDuration = restTime;
  let isPaused = false;

  function debounce(func, delay) {
    let timeout;
    return function (...args) {
      clearTimeout(timeout);
      timeout = setTimeout(() => func.apply(this, args), delay);
    };
  }

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

  function updateUserRestTime(userId, newRestTime) {
    fetch(`/users/${userId}/update_rest_time`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content,
      },
      body: JSON.stringify({ rest_time: newRestTime }),
    })
      .then((res) => {
        if (!res.ok) throw new Error("Failed to update rest time");
        return res.json();
      })
      .then((data) => {
        console.log("Updated rest time to:", data.rest_time);
      })
      .catch((err) => console.error(err));
  }

  const debouncedUpdate = debounce((userId, newTime) => {
    updateUserRestTime(userId, newTime);
  }, 500);
  
  durationInput.addEventListener("input", () => {
    const newTime = parseInt(durationInput.value, 10);
    if (!isNaN(newTime)) {
      remainingTime = newTime;
      defaultDuration = newTime;
      updateDisplay();
      debouncedUpdate(userId, newTime);
    }
  });

  startBtn.addEventListener("click", startTimer);
  pauseBtn.addEventListener("click", pauseTimer);
  resetBtn.addEventListener("click", resetTimer);

  updateDisplay();
  setButtonState({ running: false, paused: false });
});
