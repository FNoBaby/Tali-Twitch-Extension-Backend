const { recruitParticipants } = require('./recruitment.js');
const { planHeist } = require('./planning.js');
const { executeHeist } = require('./execution.js');
const { escapeHeist } = require('./escape.js');

function initializeRoles(userRoles) {
    console.log("Initializing roles...");
    const roles = {};
    for (const role in userRoles) {
        roles[userRoles[role]] = [];
    }
    return roles;
}

async function executePhase(phase, roles) {
    console.log(`Executing ${phase} phase...`);
    switch (phase) {
        case 'Recruitment':
            await recruitParticipants(roles);
            break;
        case 'Planning':
            planHeist(roles);
            break;
        case 'Execution':
            executeHeist(roles);
            break;
        case 'Escape':
            escapeHeist(roles);
            break;
        default:
            console.log("Unknown phase");
    }
}

module.exports = { initializeRoles, executePhase };
