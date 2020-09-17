-- MySQL Script generated by MySQL Workbench
-- Thu Sep 17 15:15:35 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema cdb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema cdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cdb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `cdb` ;

-- -----------------------------------------------------
-- Table `cdb`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cdb`.`employee` (
  `emp_id` INT NOT NULL,
  `first_name` VARCHAR(40) NOT NULL,
  `last_name` VARCHAR(40) NOT NULL,
  `birth_day` DATE NOT NULL,
  `sex` VARCHAR(1) NOT NULL,
  `salary` INT NOT NULL,
  `super_id` INT NOT NULL,
  `branch_id` INT NOT NULL,
  PRIMARY KEY (`emp_id`),
  INDEX `branch_id` (`branch_id` ASC) VISIBLE,
  INDEX `super_id` (`super_id` ASC) VISIBLE,
  CONSTRAINT `employee_ibfk_1`
    FOREIGN KEY (`branch_id`)
    REFERENCES `cdb`.`branch` (`branch_id`)
    ON DELETE SET NULL,
  CONSTRAINT `employee_ibfk_2`
    FOREIGN KEY (`super_id`)
    REFERENCES `cdb`.`employee` (`emp_id`)
    ON DELETE SET NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cdb`.`branch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cdb`.`branch` (
  `branch_id` INT NOT NULL,
  `branch_name` VARCHAR(40) NULL DEFAULT NULL,
  `mgr_id` INT NULL DEFAULT NULL,
  `mgr_start_date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`branch_id`),
  INDEX `mgr_id` (`mgr_id` ASC) VISIBLE,
  CONSTRAINT `branch_ibfk_1`
    FOREIGN KEY (`mgr_id`)
    REFERENCES `cdb`.`employee` (`emp_id`)
    ON DELETE SET NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cdb`.`branch_supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cdb`.`branch_supplier` (
  `branch_id` INT NOT NULL,
  `supplier_name` VARCHAR(40) NOT NULL,
  `supply_type` VARCHAR(40) NULL DEFAULT NULL,
  PRIMARY KEY (`branch_id`),
  CONSTRAINT `branch_supplier_ibfk_1`
    FOREIGN KEY (`branch_id`)
    REFERENCES `cdb`.`branch` (`branch_id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cdb`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cdb`.`client` (
  `client_id` INT NOT NULL,
  `client_name` VARCHAR(40) NULL DEFAULT NULL,
  `branch_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`client_id`),
  INDEX `branch_id` (`branch_id` ASC) VISIBLE,
  CONSTRAINT `client_ibfk_1`
    FOREIGN KEY (`branch_id`)
    REFERENCES `cdb`.`branch` (`branch_id`)
    ON DELETE SET NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cdb`.`works_with`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cdb`.`works_with` (
  `emp_id` INT NOT NULL,
  `client_id` INT NOT NULL,
  `total_sales` INT NULL DEFAULT NULL,
  PRIMARY KEY (`emp_id`, `client_id`),
  INDEX `client_id` (`client_id` ASC) VISIBLE,
  CONSTRAINT `works_with_ibfk_1`
    FOREIGN KEY (`emp_id`)
    REFERENCES `cdb`.`employee` (`emp_id`)
    ON DELETE CASCADE,
  CONSTRAINT `works_with_ibfk_2`
    FOREIGN KEY (`client_id`)
    REFERENCES `cdb`.`client` (`client_id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
