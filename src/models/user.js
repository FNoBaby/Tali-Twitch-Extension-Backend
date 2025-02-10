const connection = require('../db.js');

async function getAllUsers() {
    const [rows] = await connection.execute('SELECT * FROM users');
    return rows;
}

async function getUserById(id) {
    const [rows] = await connection.execute('SELECT * FROM users WHERE id = ?', [id]);
    return rows[0];
}

async function createUser(username, role) {
    const [result] = await connection.execute('INSERT INTO users (username, role) VALUES (?, ?)', [username, role]);
    return result.insertId;
}

module.exports = { getAllUsers, getUserById, createUser };
