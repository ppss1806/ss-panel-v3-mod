CREATE TABLE `email_verify` ( `id` BIGINT NOT NULL , `email` TEXT NOT NULL , `ip` TEXT NOT NULL , `expire_in` DATETIME NOT NULL , `count` INT NOT NULL DEFAULT '0' ) ENGINE = InnoDB;

ALTER TABLE `email_verify` CHANGE `expire_in` `expire_in` BIGINT NOT NULL;

ALTER TABLE `email_verify` DROP `count`;

ALTER TABLE `email_verify` ADD `code` TEXT NOT NULL AFTER `expire_in`;