const express = require('express')
var cors = require('cors')
const axios = require('axios')
const bodyParser = require('body-parser');
const app = express()

const APP_PORT = require('./config').APP_PORT

app.use(bodyParser.urlencoded({ extended: true }))
app.use(cors())
app.use(express.json());


app.get('/', (req, res) => {

    res.status(200).send({ msg: "Back" })

  })

app.listen(APP_PORT, () => {
  console.log(`Example app listening on port ${APP_PORT}`)
})
