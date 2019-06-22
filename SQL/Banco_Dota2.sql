-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema ibd_dota2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ibd_dota2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ibd_dota2` DEFAULT CHARACTER SET utf8 ;
USE `ibd_dota2` ;

-- -----------------------------------------------------
-- Table `ibd_dota2`.`game_mode`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ibd_dota2`.`game_mode` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibd_dota2`.`lobby_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ibd_dota2`.`lobby_type` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibd_dota2`.`match`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ibd_dota2`.`match` (
  `match_id` INT NOT NULL,
  `game_mode` INT NOT NULL,
  `lobby_type` INT NOT NULL,
  `radiant_win` TINYINT(1) NOT NULL,
  `duration` INT NOT NULL,
  `human_players` INT NOT NULL,
  `tower_status_dire` INT NOT NULL,
  `towre_status_radiant` INT NOT NULL,
  `barracks_status_radiant` INT NOT NULL,
  `barracks_status_dire` INT NOT NULL,
  `first_blood_time` INT NOT NULL,
  PRIMARY KEY (`match_id`),
  INDEX `game_mode_idx` (`game_mode` ASC),
  INDEX `lobby_type_idx` (`lobby_type` ASC),
  CONSTRAINT `game_mode`
    FOREIGN KEY (`game_mode`)
    REFERENCES `ibd_dota2`.`game_mode` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `lobby_type`
    FOREIGN KEY (`lobby_type`)
    REFERENCES `ibd_dota2`.`lobby_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibd_dota2`.`order_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ibd_dota2`.`order_types` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibd_dota2`.`gold_reasons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ibd_dota2`.`gold_reasons` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibd_dota2`.`xp_reasons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ibd_dota2`.`xp_reasons` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibd_dota2`.`item_ids`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ibd_dota2`.`item_ids` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`, `name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibd_dota2`.`chat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ibd_dota2`.`chat` (
  `chat_match_id` INT NOT NULL,
  `chat_id` INT NOT NULL,
  `time` INT NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `unit` VARCHAR(45) NOT NULL,
  `key` VARCHAR(45) NOT NULL,
  `slot` INT NOT NULL,
  PRIMARY KEY (`chat_id`),
  CONSTRAINT `chat_match_id`
    FOREIGN KEY (`chat_match_id`)
    REFERENCES `ibd_dota2`.`match` (`match_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibd_dota2`.`player`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ibd_dota2`.`player` (
  `player_match_id` INT NOT NULL,
  `gold_spent` INT NOT NULL,
  `gold` INT NOT NULL,
  `xp_per_min` INT NOT NULL,
  `level` INT NOT NULL,
  `hero_id` INT NOT NULL,
  `hero_healing` INT NOT NULL,
  `hero_damage` INT NOT NULL,
  `leaver_status` INT NOT NULL,
  `tower_damage` INT NOT NULL,
  `last_hits` INT NOT NULL,
  `kills` INT NOT NULL,
  `denies` INT NOT NULL,
  `deaths` INT NOT NULL,
  `gold_per_min` INT NOT NULL,
  `item_0` INT NOT NULL,
  `item_1` INT NOT NULL,
  `item_2` INT NOT NULL,
  `item_3` INT NOT NULL,
  `item_4` INT NOT NULL,
  `item_5` INT NOT NULL,
  `assists` INT NOT NULL,
  `account_id` INT NOT NULL,
  PRIMARY KEY (`account_id`, `player_match_id`),
  INDEX `player_match_id_idx` (`player_match_id` ASC),
  CONSTRAINT `player_match_id`
    FOREIGN KEY (`player_match_id`)
    REFERENCES `ibd_dota2`.`match` (`match_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibd_dota2`.`damage`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ibd_dota2`.`damage` (
  `damage_match_id` INT NOT NULL,
  `damage_account_id` INT NOT NULL,
  `unit_damaged` INT NOT NULL,
  `damage_count` INT NOT NULL,
  PRIMARY KEY (`damage_match_id`, `damage_account_id`, `unit_damaged`),
  INDEX `damage_account_id_idx` (`damage_account_id` ASC),
  CONSTRAINT `damage_match_id`
    FOREIGN KEY (`damage_match_id`)
    REFERENCES `ibd_dota2`.`player` (`player_match_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `damage_account_id`
    FOREIGN KEY (`damage_account_id`)
    REFERENCES `ibd_dota2`.`player` (`account_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibd_dota2`.`lane_pos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ibd_dota2`.`lane_pos` (
  `pos_match_id` INT NOT NULL,
  `pos_account_id` INT NOT NULL,
  `x_pos` INT NOT NULL,
  `y_pos` INT NOT NULL,
  `pos_count` INT NOT NULL,
  PRIMARY KEY (`pos_match_id`, `pos_account_id`, `x_pos`, `y_pos`),
  INDEX `pos_account_id_idx` (`pos_account_id` ASC),
  CONSTRAINT `pos_match_id`
    FOREIGN KEY (`pos_match_id`)
    REFERENCES `ibd_dota2`.`player` (`player_match_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `pos_account_id`
    FOREIGN KEY (`pos_account_id`)
    REFERENCES `ibd_dota2`.`player` (`account_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibd_dota2`.`player_gold_reasons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ibd_dota2`.`player_gold_reasons` (
  `gold_match_id` INT NOT NULL,
  `gold_account_id` INT NOT NULL,
  `gold_id` INT NOT NULL,
  `gold_count` INT NOT NULL,
  PRIMARY KEY (`gold_match_id`, `gold_account_id`, `gold_id`),
  INDEX `gold_account_id_idx` (`gold_account_id` ASC),
  INDEX `gold_id_idx` (`gold_id` ASC),
  CONSTRAINT `gold_match_id`
    FOREIGN KEY (`gold_match_id`)
    REFERENCES `ibd_dota2`.`player` (`player_match_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `gold_account_id`
    FOREIGN KEY (`gold_account_id`)
    REFERENCES `ibd_dota2`.`player` (`account_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `gold_id`
    FOREIGN KEY (`gold_id`)
    REFERENCES `ibd_dota2`.`gold_reasons` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibd_dota2`.`actions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ibd_dota2`.`actions` (
  `action_match_id` INT NOT NULL,
  `action_account_id` INT NOT NULL,
  `action_id` INT NOT NULL,
  `action_count` INT NOT NULL,
  PRIMARY KEY (`action_match_id`, `action_account_id`, `action_id`),
  INDEX `action_account_id_idx` (`action_account_id` ASC),
  INDEX `action_id_idx` (`action_id` ASC),
  CONSTRAINT `action_match_id`
    FOREIGN KEY (`action_match_id`)
    REFERENCES `ibd_dota2`.`player` (`player_match_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `action_account_id`
    FOREIGN KEY (`action_account_id`)
    REFERENCES `ibd_dota2`.`player` (`account_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `action_id`
    FOREIGN KEY (`action_id`)
    REFERENCES `ibd_dota2`.`order_types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibd_dota2`.`obs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ibd_dota2`.`obs` (
  `obs_match_id` INT NOT NULL,
  `obs_account_id` INT NOT NULL,
  `x_pos` INT NOT NULL,
  `y_pos` INT NOT NULL,
  `obs_count` INT NOT NULL,
  PRIMARY KEY (`obs_match_id`, `obs_account_id`, `x_pos`, `y_pos`),
  INDEX `obs_account_id_idx` (`obs_account_id` ASC),
  CONSTRAINT `obs_match_id`
    FOREIGN KEY (`obs_match_id`)
    REFERENCES `ibd_dota2`.`player` (`player_match_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `obs_account_id`
    FOREIGN KEY (`obs_account_id`)
    REFERENCES `ibd_dota2`.`player` (`account_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibd_dota2`.`sen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ibd_dota2`.`sen` (
  `sen_match_id` INT NOT NULL,
  `sen_account_id` INT NOT NULL,
  `x_pos` INT NOT NULL,
  `y_pos` INT NOT NULL,
  `sen_count` INT NOT NULL,
  PRIMARY KEY (`sen_match_id`, `sen_account_id`, `x_pos`, `y_pos`),
  INDEX `sen_account_id_idx` (`sen_account_id` ASC),
  CONSTRAINT `sen_match_id`
    FOREIGN KEY (`sen_match_id`)
    REFERENCES `ibd_dota2`.`player` (`player_match_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sen_account_id`
    FOREIGN KEY (`sen_account_id`)
    REFERENCES `ibd_dota2`.`player` (`account_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibd_dota2`.`player_xp_reasons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ibd_dota2`.`player_xp_reasons` (
  `xp_match_id` INT NOT NULL,
  `xp_account_id` INT NOT NULL,
  `xp_id` INT NOT NULL,
  `xp_count` INT NOT NULL,
  PRIMARY KEY (`xp_match_id`, `xp_account_id`, `xp_id`),
  INDEX `xp_account_id_idx` (`xp_account_id` ASC),
  INDEX `xp_id_idx` (`xp_id` ASC),
  CONSTRAINT `xp_match_id`
    FOREIGN KEY (`xp_match_id`)
    REFERENCES `ibd_dota2`.`player` (`player_match_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `xp_account_id`
    FOREIGN KEY (`xp_account_id`)
    REFERENCES `ibd_dota2`.`player` (`account_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `xp_id`
    FOREIGN KEY (`xp_id`)
    REFERENCES `ibd_dota2`.`xp_reasons` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibd_dota2`.`killed`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ibd_dota2`.`killed` (
  `killed_match_id` INT NOT NULL,
  `killed_account_id` INT NOT NULL,
  `unit_killed` INT NOT NULL,
  `killed_count` INT NOT NULL,
  PRIMARY KEY (`killed_match_id`, `killed_account_id`, `unit_killed`),
  INDEX `killed_account_id_idx` (`killed_account_id` ASC),
  CONSTRAINT `killed_match_id`
    FOREIGN KEY (`killed_match_id`)
    REFERENCES `ibd_dota2`.`player` (`player_match_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `killed_account_id`
    FOREIGN KEY (`killed_account_id`)
    REFERENCES `ibd_dota2`.`player` (`account_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibd_dota2`.`healing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ibd_dota2`.`healing` (
  `healing_match_id` INT NOT NULL,
  `healing_account_id` INT NOT NULL,
  `unit_healed` INT NOT NULL,
  `healing_count` INT NOT NULL,
  PRIMARY KEY (`healing_match_id`, `healing_account_id`, `unit_healed`),
  INDEX `healing_account_id_idx` (`healing_account_id` ASC),
  CONSTRAINT `healing_match_id`
    FOREIGN KEY (`healing_match_id`)
    REFERENCES `ibd_dota2`.`player` (`player_match_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `healing_account_id`
    FOREIGN KEY (`healing_account_id`)
    REFERENCES `ibd_dota2`.`player` (`account_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibd_dota2`.`item_uses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ibd_dota2`.`item_uses` (
  `item_match_id` INT NOT NULL,
  `item_account_id` INT NOT NULL,
  `item_name` VARCHAR(45) NOT NULL,
  `item_count` INT NOT NULL,
  PRIMARY KEY (`item_match_id`, `item_account_id`, `item_name`),
  INDEX `item_account_id_idx` (`item_account_id` ASC),
  INDEX `item_name_idx` (`item_name` ASC),
  CONSTRAINT `item_match_id`
    FOREIGN KEY (`item_match_id`)
    REFERENCES `ibd_dota2`.`player` (`player_match_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `item_account_id`
    FOREIGN KEY (`item_account_id`)
    REFERENCES `ibd_dota2`.`player` (`account_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `item_name`
    FOREIGN KEY (`item_name`)
    REFERENCES `ibd_dota2`.`item_ids` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
