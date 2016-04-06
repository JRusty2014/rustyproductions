-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema dadev
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema dadev
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dadev` DEFAULT CHARACTER SET utf8 ;
USE `dadev` ;

-- -----------------------------------------------------
-- Table `dadev`.`apps`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dadev`.`apps` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dadev`.`lobs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dadev`.`lobs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dadev`.`depts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dadev`.`depts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `lobs_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_depts_lobs_idx` (`lobs_id` ASC),
  CONSTRAINT `fk_depts_lobs`
    FOREIGN KEY (`lobs_id`)
    REFERENCES `dadev`.`lobs` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dadev`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dadev`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `password` VARCHAR(255) NOT NULL,
  `username` INT NOT NULL,
  `emp_name` VARCHAR(45) NOT NULL,
  `emp_email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dadev`.`requests`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dadev`.`requests` (
  `id` INT NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `req_description` TEXT(5000) NOT NULL,
  `requestor_id` INT NOT NULL,
  `dept_id` INT NOT NULL,
  `lob_id` INT NOT NULL,
  `app_id` INT NOT NULL,
  `req_type` ENUM('Audit', 'SOX', 'Issue', 'Project') NOT NULL,
  `req_status` ENUM('New', 'In Progress', 'Complete') NOT NULL DEFAULT 'New',
  `assigned_to` INT NULL,
  `admin_notes` TEXT(5000) NULL,
  `attachment_path` VARCHAR(255) NULL,
  PRIMARY KEY (`id`, `requestor_id`, `app_id`),
  INDEX `fk_requests_users1_idx` (`requestor_id` ASC),
  INDEX `fk_requests_depts1_idx` (`dept_id` ASC),
  INDEX `fk_requests_lobs1_idx` (`lob_id` ASC),
  INDEX `fk_requests_apps1_idx` (`app_id` ASC),
  INDEX `fk_requests_users2_idx` (`assigned_to` ASC),
  CONSTRAINT `fk_requests_users1`
    FOREIGN KEY (`requestor_id`)
    REFERENCES `dadev`.`users` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_requests_depts1`
    FOREIGN KEY (`dept_id`)
    REFERENCES `dadev`.`depts` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_requests_lobs1`
    FOREIGN KEY (`lob_id`)
    REFERENCES `dadev`.`lobs` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_requests_apps1`
    FOREIGN KEY (`app_id`)
    REFERENCES `dadev`.`apps` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_requests_users2`
    FOREIGN KEY (`assigned_to`)
    REFERENCES `dadev`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
