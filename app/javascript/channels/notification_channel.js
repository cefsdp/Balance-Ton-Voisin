import consumer from "./consumer";

const initNotificationChannel = () => {
  consumer.subscriptions.create( "NotificationChannel", {
    received(data) {
      document.location.reload();
      // console.log(data["txt"])
      // const notifContainer = document.querySelector('.dropnotifs');
      // notifContainer.insertAdjacentHTML('afterbegin', `<div class="dropdown-item notif"><div class="new"></div><div class="text">${data["txt"]}</div></div>`);
    }
  })
}

export { initNotificationChannel };