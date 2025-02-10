const connection = require('../db.js');

async function recruitParticipants(roles) {
    console.log("Recruiting participants...");
    const [rows] = await connection.execute('SELECT * FROM users');
    rows.forEach(user => {
        if (roles[user.role]) {
            roles[user.role].push(user);
        }
    });
    console.log("Participants recruited:", roles);
    return roles;
}

module.exports = { recruitParticipants };
