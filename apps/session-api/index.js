const express = require('express')
var cors = require('cors')
const bodyParser = require('body-parser');
const app = express()
app.use(bodyParser.urlencoded({ extended: true }))
app.use(cors())
app.use(express.json());

var port = process.env.APP_PORT;
var redisPort = process.env.REDIS_PORT;
var redisHost = process.env.REDIS_HOST;

var Redis = require('ioredis');
var client = new Redis({
  port: redisPort,          // Redis port
  host: redisHost,   // Redis host
  family: 4,           // 4 (IPv4) or 6 (IPv6)
  //password: process.env.REDIS_PASSWORD,
  db: 0
});


app.get('/', (req, res) => {
    res.send(process.env)
})

app.post('/sessionExists', (req, res) => {
    var body = req.body
    if(body.session){
        client.get(body.session)
        .then(r => {
            console.log(r);
            if (r) res.send({ status: 200, msg: true })
            else {
                client.set(body.session, JSON.stringify("X"))
                .then(r => {
                    res.send({
                        status: 200,
                        msg: body.session
                    })
                })
            }
        }).catch(err => {
            res.send({ status: 500, msg: err })
        })
    }else{
        res.send({ status: 200, msg: false })
    }
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})
