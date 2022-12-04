const express = require('express')
var cors = require('cors')
const axios = require('axios')
const bodyParser = require('body-parser');
const app = express()
app.use(bodyParser.urlencoded({ extended: true }))
app.use(cors())
app.use(express.json());
const port = process.env.APP_PORT
const kafkaHost = process.env.KAFKA_HOST//'http://localhost:4000'

var kafka = require('kafka-node');
var Producer = kafka.Producer;
const client = new kafka.KafkaClient({kafkaHost: kafkaHost});
var producer = new Producer(client);
var KeyedMessage = kafka.KeyedMessage;


producer.on('ready', function () {
    
});

producer.on('error', function (err) {
    console.log(err)
})


app.post('/', (req, res) => {
    var body = req.body

    var d = JSON.stringify(body.userData)

    km = new KeyedMessage('key', 'message'),
        payloads = [
            { topic: 'topic-user', messages: d, partition: 0 }
        ];

    producer.send(payloads, function (err, data) {
        if(err) {
            res.send({ status: 500, msg: err })
        } else {
            res.send({ status: 500, msg: data })
        }
    });
  })

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})
