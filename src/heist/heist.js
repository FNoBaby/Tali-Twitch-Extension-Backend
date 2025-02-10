const { initializeRoles, executePhase } = require('./phases.js');

async function startHeist(userRoles) {
    console.log("Starting the heist...");
    const roles = initializeRoles(userRoles);
    await executePhase('Recruitment', roles);
    executePhase('Planning', roles);
    executePhase('Execution', roles);
    executePhase('Escape', roles);
    console.log("Heist completed!");
}

module.exports = { startHeist };
