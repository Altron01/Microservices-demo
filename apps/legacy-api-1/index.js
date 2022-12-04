var kafka = require('kafka-node');
const postUser = require('./interfaces/db_interface').postUser;
var Consumer = kafka.Consumer;
const client = new kafka.KafkaClient({kafkaHost: '172.16.0.204:9092'});
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
  postUser(JSON.parse(message.value));
});
