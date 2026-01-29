(function ($) {
  "use strict";

  // Get Current Year
  document.querySelectorAll("[data-year]").forEach(function (el) {
    el.textContent = new Date().getFullYear();
  });

  // Dropdown
  const dropdown = document.querySelectorAll('[data-dropdown]');
  if (dropdown) {
    dropdown.forEach(function (el) {
      let dropdownClose = el.querySelectorAll("[data-dropdown-close]");
      window.addEventListener("click", function (e) {
        if (el.contains(e.target) && el.hasAttribute("data-dropdown-propagation")) {
          if (!e.target.closest(".drop-down-menu")) {
            el.classList.toggle('active');
            setTimeout(function () {
              el.classList.toggle('animated');
            }, 0);
          }
        } else if (el.contains(e.target)) {
          el.classList.toggle('active');
          setTimeout(function () {
            el.classList.toggle('animated');
          }, 0);
        } else {
          el.classList.remove('active');
          el.classList.remove('animated');
        }
      });
      if (dropdownClose) {
        dropdownClose.forEach((closeBtn) => {
          closeBtn.addEventListener("click", () => {
            el.classList.remove('active');
            el.classList.remove('animated');
          });
        });
      }
    });
  }

  // Toggle
  var toggle = document.querySelectorAll('[data-toggle]');
  if (toggle) {
    toggle.forEach(function (el, id) {
      el.querySelector(".toggle-title").addEventListener("click", () => {
        for (var i = 0; i < toggle.length; i++) {
          if (i !== id) {
            toggle[i].classList.remove("active");
            toggle[i].classList.remove("animated");
          }
        }
        if (el.classList.contains("active")) {
          el.classList.remove("active");
          el.classList.remove("animated");
        } else {
          el.classList.add("active");
          setTimeout(function () {
            el.classList.add("animated");
          }, 0);
        }
      });
    });
  }

  // Dashboard
  const dashboard = document.querySelector(".dashboard"),
    dashboardToggleBtn = document.querySelectorAll(".dashboard-toggle-btn");
  if (dashboard) {
    dashboardToggleBtn.forEach((el) => {
      el.addEventListener("click", () => {
        dashboard.classList.toggle("toggle");
      });
    });
    dashboard.querySelector(".dashboard-sidebar .overlay").addEventListener("click", () => {
      dashboard.classList.remove("toggle");
    });
  }

  // Upload Image
  // Upload Image
document.querySelectorAll(".upload-image").forEach(imgContainer => {
    let imgInput = imgContainer.querySelector("input"),
        imgFile = imgContainer.querySelector("img");

    imgInput.onchange = () => {
      const [file] = imgInput.files;
      if (file) {
        imgFile.src = URL.createObjectURL(file);
        imgContainer.classList.add("active");
      } else {
        imgFile.src = '';
        imgContainer.classList.remove("active");
      }
    };
  });

  // Announcement


  // Password Input
  let password = document.querySelectorAll(".input-password");
  if (password) {
    password.forEach((el) => {
      let passwordBtn = el.querySelector("button"),
          passwordInput = el.querySelector("input");
      passwordBtn.onclick = (e) => {
        e.preventDefault();
        if (passwordInput.type === "password") {
          passwordInput.type = "text";
          passwordBtn.innerHTML = `<i class="fas fa-eye-slash"></i>`;
        } else {
          passwordInput.type = "password";
          passwordBtn.innerHTML = `<i class="fas fa-eye"></i>`;
        }
      };
    });
  }

  // Steps
  const stepSidebar = document.querySelector(".steps-sidebar");
  if (stepSidebar) {
    const sidebarToggle = document.querySelector(".sidebar-toggle"),
      sidebarClose = document.querySelector(".sidebar-close");
      sidebarToggle.addEventListener("click", () => {
      stepSidebar.classList.add("show");
    });
    sidebarClose.addEventListener("click", () => {
      stepSidebar.classList.remove("show");
    });
  }

  $('.tagsinput input').tagsinput({
    cancelConfirmKeysOnEmpty: false
  });

  const goToValue = document.getElementById('goToValue');

    if (goToValue) {
        goToValue.addEventListener('change', function() {
            var selectedValue = this.value;
            if (selectedValue) {
                window.location.href = selectedValue; // Redirect to the selected route
            }
        });
    }


    const deleteModal = document.getElementById('deleteModal');
    if(deleteModal){
        document.addEventListener('DOMContentLoaded', function() {
            deleteModal.addEventListener('show.bs.modal', function(event) {
                const button = event.relatedTarget; // Button that triggered the modal
                const id = button.getAttribute('data-id'); // Extract info from data-* attributes
                const action = button.getAttribute('data-action');

                const form = deleteModal.querySelector('#deleteForm');
                form.setAttribute('action', action); // Set the form action attribute to the delete URL
            });
        });
    }


    var gatewayValue = $("input[name='gateway']:checked").val();

    // Check if "bank" is selected or no radio button is checked, then show the div, otherwise hide it
    if (gatewayValue === "bank") {
        $('#bankDiv').show();
    } else {
        $('#bankDiv').hide();
    }

    // Listen for changes in the radio button selection
    $('input[name="gateway"]').on('change', function () {
        var gatewayValue = $('input[name="gateway"]:checked').val();

        if (gatewayValue === "bank") {
            $('#bankDiv').show();
        } else {
            $('#bankDiv').hide();
        }
    });


            var discountDiv = $('#discountDiv');
            var discountInput = $('input[name="discount"]').val();

            $('.discount-btn').on('click', function () {
                discountDiv.toggle();
            });

            if (discountInput && discountInput.trim()) {
                discountDiv.show();
            } else {
                discountDiv.hide();
            }



            const progressBar = document.getElementById('paymentProgressBar');
            const statusMessage = document.getElementById('statusMessage');

            const stages = [{
                    until: 12,
                    message: Initializing
                },
                {
                    until: 29,
                    message: Contacting
                },
                {
                    until: 45,
                    message: Verifying
                },
                {
                    until: 66,
                    message: Processing
                },
                {
                    until: 90,
                    message: Finalizing
                },
                {
                    until: 98,
                    message: Redirecting
                }
            ];

            let currentProgress = 0;
            let currentStageIndex = 0;

            function updateProgress() {

                if (!progressBar || !statusMessage) return;

                const delay = Math.floor(Math.random() * (1400 - 500 + 1)) + 500; // Random delay
                const step = Math.floor(Math.random() * (7 - 2 + 1)) + 2; // Random step between 2-7

                setTimeout(() => {
                    if (currentProgress < 98) {
                        currentProgress += step;
                        if (currentProgress > 98) currentProgress = 98;

                        progressBar.style.width = currentProgress + '%';
                        progressBar.textContent = currentProgress + '%';
                        progressBar.parentElement.setAttribute('aria-valuenow', currentProgress);

                        // Check if we should show next message
                        if (currentStageIndex < stages.length && currentProgress >= stages[
                                currentStageIndex].until) {
                            statusMessage.textContent = stages[currentStageIndex].message;
                            currentStageIndex++;
                        }

                        updateProgress();
                    } else {
                        // Wait a bit, then complete
                        setTimeout(() => {
                            progressBar.style.width = '100%';
                            progressBar.textContent = '100%';
                            progressBar.parentElement.setAttribute('aria-valuenow', 100);
                            statusMessage.textContent = Redirecting;

                            // redirect here
                            window.location.href = billing_page;
                        }, 1000);
                    }
                }, delay);
            }

            updateProgress();

})(jQuery);
