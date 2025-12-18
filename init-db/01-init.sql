-- Initialize databases for 1100CC and nodegoat

-- Create additional users
CREATE USER IF NOT EXISTS '1100CC_home'@'%' IDENTIFIED BY 'home_password';

-- Create nodegoat databases
CREATE DATABASE IF NOT EXISTS nodegoat_cms CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS nodegoat_home CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS nodegoat_content CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS nodegoat_temp CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Grant privileges for 1100CC core
GRANT SELECT, INSERT, UPDATE, DELETE ON 1100CC.* TO '1100CC_cms'@'%';
GRANT SELECT ON 1100CC.* TO '1100CC_home'@'%';

-- Grant privileges for nodegoat_cms database
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER, INDEX, CREATE TEMPORARY TABLES, SHOW VIEW, CREATE VIEW, EXECUTE ON nodegoat_cms.* TO '1100CC_cms'@'%';
GRANT SELECT ON nodegoat_cms.* TO '1100CC_home'@'%';

-- Grant privileges for nodegoat_home database
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER, INDEX, CREATE TEMPORARY TABLES, SHOW VIEW, CREATE VIEW, EXECUTE ON nodegoat_home.* TO '1100CC_cms'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON nodegoat_home.* TO '1100CC_home'@'%';

-- Grant privileges for nodegoat_content database
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER, INDEX, CREATE TEMPORARY TABLES, SHOW VIEW, CREATE VIEW, EXECUTE ON nodegoat_content.* TO '1100CC_cms'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON nodegoat_content.* TO '1100CC_home'@'%';

-- Grant privileges for nodegoat_temp database
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, CREATE TEMPORARY TABLES, EXECUTE, CREATE ROUTINE, ALTER ROUTINE ON nodegoat_temp.* TO '1100CC_cms'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, CREATE TEMPORARY TABLES, EXECUTE ON nodegoat_temp.* TO '1100CC_home'@'%';

FLUSH PRIVILEGES;