const notif_reader = () => {
    const ping = document.querySelector(".notif");
    ping.addEventListener("click", (event) => {
        console.log(event)
    });
};

export { notif_reader };

// user.notifications.read