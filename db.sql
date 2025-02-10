-- Create Users Table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    twitch_id VARCHAR(255) UNIQUE NOT NULL,
    username VARCHAR(255) NOT NULL,
    avatar_url TEXT,
    total_loot BIGINT DEFAULT 0,  -- Total earnings from heists
    heists_participated INT DEFAULT 0,
    heists_won INT DEFAULT 0,
    role_preference VARCHAR(50),  -- Preferred role (e.g., Hacker, Driver)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Heists Table
CREATE TABLE heists (
    id INT AUTO_INCREMENT PRIMARY KEY,
    streamer_id VARCHAR(255) NOT NULL,  -- Twitch ID of streamer
    heist_name VARCHAR(255) NOT NULL,  -- Custom name of the heist
    difficulty ENUM('Easy', 'Medium', 'Hard', 'Insane') NOT NULL,
    status ENUM('Planned', 'In Progress', 'Success', 'Failed') DEFAULT 'Planned',
    loot_value BIGINT DEFAULT 0,  -- Total loot in this heist
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Heist Participants Table
CREATE TABLE heist_participants (
    id INT AUTO_INCREMENT PRIMARY KEY,
    heist_id INT NOT NULL,
    user_id INT NOT NULL,
    role ENUM('Mastermind', 'Hacker', 'Thief', 'Driver', 'Muscle') NOT NULL,
    status ENUM('Success', 'Failed', 'Caught', 'Escaped') DEFAULT 'Success',
    loot_share BIGINT DEFAULT 0,  -- Loot amount they earned
    FOREIGN KEY (heist_id) REFERENCES heists(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Create Heist Events Table
CREATE TABLE heist_events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    heist_id INT NOT NULL,
    event_type ENUM('Hack Attempt', 'Bribe', 'Combat', 'Escape', 'Alarm Triggered') NOT NULL,
    event_description TEXT NOT NULL,  -- e.g., "Hacker successfully disabled security cameras!"
    success BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (heist_id) REFERENCES heists(id) ON DELETE CASCADE
);

-- Create Leaderboard Table
CREATE TABLE leaderboard (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNIQUE NOT NULL,
    total_loot BIGINT DEFAULT 0,
    heists_won INT DEFAULT 0,
    last_heist TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Create Streamer Settings Table
CREATE TABLE streamer_settings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    streamer_id VARCHAR(255) UNIQUE NOT NULL,
    max_players INT DEFAULT 10,  -- Max number of players per heist
    base_loot INT DEFAULT 1000,  -- Starting loot per heist
    difficulty_scaling BOOLEAN DEFAULT TRUE,  -- Enable difficulty adjustments?
    custom_commands JSON,  -- JSON object for custom Twitch commands
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
