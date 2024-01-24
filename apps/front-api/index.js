const express = require('express')
var cors = require('cors')
const axios = require('axios')
const bodyParser = require('body-parser');
const app = express()

const APP_PORT = require('./config').APP_PORT
const BACK_URL = require('./config').BACK_URL

app.use(bodyParser.urlencoded({ extended: true }))
app.use(cors())
app.use(express.json());


app.get('/', (req, res) => {

    axios({
      method: 'get',
      url: BACK_URL,
      data: {
        msg: "Done"
      }
    }).then(res => {
      res.status(200).send({ msg: req })
    });

  })

app.listen(APP_PORT, () => {
  console.log(`Example app listening on port ${APP_PORT}`)
})
