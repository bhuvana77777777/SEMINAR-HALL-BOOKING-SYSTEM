
function submitRequest() {
    let name = document.getElementById("name").value.trim();
    let email = document.getElementById("email").value.trim();
    let phone = document.getElementById("phoneno").value.trim();
    let eventTitle = document.getElementById("event-title").value.trim();
    let fromTime = document.getElementById("from-time").value.trim();
    let toTime = document.getElementById("to-time").value.trim();
    let capacity = document.getElementById("capacity").value.trim();
    let hall = document.getElementById("hall").value.trim();
    let date = document.getElementById("date").value.trim();

    if (name === "") {
        alert("Please fill in your name.");
        return;
    }
    if (email === "") {
        alert("Please fill in your email.");
        return;
    }
    if (phone === "") {
        alert("Please fill in your phone number.");
        return;
    }
    if (eventTitle === "") {
        alert("Please fill in the event title.");
        return;
    }
    if (fromTime === "") {
        alert("Please select a start time.");
        return;
    }
    if (toTime === "") {
        alert("Please select an end time.");
        return;
    }
    if (capacity === "") {
        alert("Please select a capacity.");
        return;
    }
    if (hall === "") {
        alert("Please select a hall.");
        return;
    }
    if (date === "") {
        alert("Please select a date.");
        return;
    }

    alert("Your seminar hall booking request has been submitted successfully!");
}

// Function to update available halls based on capacity
function updateHalls() {
    const halls = {
        "60": ["Admin Auditorium"],
         "200": ["Admin Seminar Hall 1", "Admin Seminar Hall 2", "Library Auditorium"],
         "120": ["CSE","ECE", "Civil, EEE, Chemical", "Data Science", "Mech, MBA", "IT"]
        
     };

    let selectedCapacity = document.getElementById("capacity").value;
    let hallSelect = document.getElementById("hall");
    hallSelect.innerHTML = "";

    halls[selectedCapacity].forEach(hall => {
        let option = document.createElement("option");
        option.value = hall;
        option.textContent = hall;
        hallSelect.appendChild(option);
    });
}