import consumer from "./consumer";

const initNotificationChannel = () => {
  // const messagesContainer = document.getElementById('messages');
  // if (messagesContainer) {
   // const id = messagesContainer.dataset.chatroomId;

    consumer.subscriptions.create({ channel: "NotificationChannel", id: 2 }, {
        connected() {
            console.log('io')
        },

      received(data) {
        console.log(data); // called when data is broadcast in the cable
      },
    });
  // }
}

export { initNotificationChannel };