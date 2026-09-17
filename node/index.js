const express = require('express');
const app = express();
const port = 3000;
const mysql = require('mysql2');

const connection = mysql.createConnection({
    host: process.env.DB_HOST || 'db',
    port: Number(process.env.DB_PORT || 3306),
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_DATABASE,
});

connection.on('error', (error) => {
    console.log('Erro de conexão MySQL:', error.message);
});

const sql = "INSERT INTO `user` (nome) VALUES ('nome')";

connection.query(sql, (error, result) => {
    if (error) {
        console.log('Erro:', error);
        return;
    }

    console.log('Usuário cadastrado com sucesso!');
    console.log('ID:', result.insertId);
});

connection.end();

app.get('/', (req, res) => {
    res.send('<h1>Rodando Node com Docker! </h1>')
});

app.listen(port, () => {
    console.log("Rodando na porta" + port)
});
