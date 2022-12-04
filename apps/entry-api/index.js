const express = require('express')
var cors = require('cors')
const axios = require('axios')
const bodyParser = require('body-parser');
var db_interface = require('./interfaces/db_interface')
const app = express()
app.use(bodyParser.urlencoded({ extended: true }))
app.use(cors())
app.use(express.json());
const port = process.env.APP_PORT
const sessionAPI = process.env.SESSION_API//'http://localhost:4000'
const depoAPI = process.env.DEPO_API

app.post('/postUser', (req, res) => {
    var body = req.body
    axios.post(sessionAPI + '/sessionExists', {
        session: body.session
    }).then(r => {
      if(r.msg) {
        return axios.post(depoAPI + '/', {
          userData: body.userData
        })
      }else res.send({ status: 500, msg: "WHY" })
    })
  })

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})
