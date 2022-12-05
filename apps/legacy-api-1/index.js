var kafka = require('kafka-node');
const postUser = require('./interfaces/db_interface').postUser;
var Consumer = kafka.Consumer;
const client = new kafka.KafkaClient({kafkaHost: process.env.KAFKA_HOST});
var consumer = new Consumer(
    client,
    [
        { topic: 'topic-user', partition: 0 }
    ],
    {
        autoCommit: false,
        groupId: 'TEST'
    }
);

consumer.on('error', function (err) { console.log(err) })
consumer.on('offserOutRange', function (err) {console.log(err)})
consumer.on('message', function (message) {
  var res = JSON.parse(message.value)
  var data = {
    UserID: res.UserID,
    desc: res.desc
  }
  postUser(data);
});
