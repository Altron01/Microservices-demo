var mysql      = require('mysql');
var connection = mysql.createConnection({
  host     : process.env.DB_HOST,
  user     : 'api',
  password : 'Altron194',
  database : 'demo'
});

connection.connect();

createUser = 'CREATE TABLE users(UserID int PRIMARY KEY,desc varchar(50));';
connection.query('DROP TABLE IF EXISTS users;', function (error, results, fields) {
  if (error) throw error;
  console.log('TABLA CREADA');
});

function postUser(user) {
    return new Promise((resolve, reject) => {
        connection.query('INSERT INTO users SET ?', user, function (error, results, fields) {
            if (error) reject(error);
            resolve(results);
          });
    });
}



module.exports = { postUser }