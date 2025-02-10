const userRoles = require('./enums/user_roles.js');
const { startHeist } = require('./heist/heist.js');

console.log("🎩 Twitch Heist – Interactive Heist Simulator 🏦💰");

startHeist(userRoles);
