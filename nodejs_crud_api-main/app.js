let express = require('express');
let app = express();
let bodyParser = require('body-parser');
let mysql = require('mysql');

const port = process.env.PORT || 3000;

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

//connect mysql database
let conn = mysql.createConnection({
    host : 'localhost',
    user: 'root',
    password: '',
    database: 'sql_api'
})

conn.connect();

app.get('/', (req, res) => {
    return res.json({
        error: false, 
        message: 'Welcome to RESTfull api with node js.'
    });
})

app.get('/users', (req, res) => {
    conn.query("SELECT * FROM users", (error, results) => {
        if (error) throw error;

        let message = ""
        if (results === undefined || results.length == 0) {
            message = "user is empty";
        } else {
            message = "Successfully retrived all users";
        }

        return res.json({
            error: false,
            message: message,
            data: results
        });
    })
})

app.post('/createUser', (req, res) => {
    let fullname = req.body.fullname;
    let username = req.body.username;
    let password = req.body.password;
    let status = req.body.status;

    //check validation
    if (!fullname || !username || !password || !status) {
        return res
        .status(400)
        .send({
            error: true,
            message: "Please provide user any name"
        });
    } else {
        let values = [fullname, username, password, status];
        conn.query('INSERT INTO users (fullname, username, password, status) VALUES(?, ?, ?, ?)', values, (error, results, fields) => {
            if (error) throw error;
            return res.send({
                error: false,
                message: 'User successfully added',
                data: []
            })
        });
    }
})

app.put('/updateUser', (req, res) => {
    let id = req.body.id;
    let fullname = req.body.fullname;
    let username = req.body.username;
    let password = req.body.password;
    let status = req.body.status;

    //check validation
    if (!fullname || !username || !password || !status || !id) {
        return res
        .status(400)
        .send({
            error: true,
            message: "Please provide id, fullname and username"
        });
    } else {
        let values = [fullname, username, password, status, id];
        conn.query('UPDATE users SET fullname = ?, username = ?, password = ?, status = ? WHERE id = ?', values, (error, results, fields) => {
            if (error) throw error;

            let message = ""
            if (results.changedRows === 0) {
                message = "User not found or data are same"
            } else {
                message = "User successfully updated"
            }

            return res.send({
                error: false,
                message: message,
                data: []
            })
        });
    }
})

app.delete('/deleteUser', (req, res) => {
    let id = req.body.id;

    //check validation
    if (!id) {
        return res
        .status(400)
        .send({
            error: true,
            message: "Please provide User id"
        });

    } else {
        let values = [id];
        conn.query('DELETE FROM users WHERE id = ?', values, (error, results, fields) => {
            if (error) throw error;

            let message = "";

            if (results.affectedRows === 0) {
                message = "User not found";
            } else {
                message = "User successfully deleted";
            }

            return res.send({
                error: false,
                message: message,
                data: []
            })
        });
    }
})


app.listen(port, () => {
    console.log("Listening on port %d", port);
})

module.exports = app;