-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Airport
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Airport
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Airport` DEFAULT CHARACTER SET utf8mb3 ;
USE `Airport` ;

-- -----------------------------------------------------
-- Table `Airport`.`airline`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airport`.`airline` (
  `airline_id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `iata_code` VARCHAR(45) NOT NULL,
  `icao_code` VARCHAR(45) NOT NULL,
  `headquarters` VARCHAR(45) NOT NULL,
  `founded` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`airline_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Airport`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airport`.`products` (
  `product_id` VARCHAR(45) NOT NULL,
  `airline_id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) CHARACTER SET 'utf8mb3' NOT NULL,
  PRIMARY KEY (`product_id`),
  INDEX `fk_products_airline1_idx` (`airline_id` ASC) VISIBLE,
  CONSTRAINT `fk_products_airline1`
    FOREIGN KEY (`airline_id`)
    REFERENCES `Airport`.`airline` (`airline_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Airport`.`accessories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airport`.`accessories` (
  `product_id` VARCHAR(45) NOT NULL,
  `accessory_id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) CHARACTER SET 'utf8mb3' NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`accessory_id`, `product_id`),
  INDEX `fk_accessories_products1_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_accessories_products1`
    FOREIGN KEY (`product_id`)
    REFERENCES `Airport`.`products` (`product_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Airport`.`additional_services`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airport`.`additional_services` (
  `product_id` VARCHAR(45) NOT NULL,
  `service_id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) CHARACTER SET 'utf8mb3' NOT NULL,
  PRIMARY KEY (`service_id`, `product_id`),
  INDEX `fk_additional_services_products1_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_additional_services_products1`
    FOREIGN KEY (`product_id`)
    REFERENCES `Airport`.`products` (`product_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Airport`.`affiliated_products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airport`.`affiliated_products` (
  `product_id` VARCHAR(45) NOT NULL,
  `affiliated_product_id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) CHARACTER SET 'utf8mb3' NOT NULL,
  PRIMARY KEY (`affiliated_product_id`, `product_id`),
  INDEX `fk_affiliated_products_products1_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_affiliated_products_products1`
    FOREIGN KEY (`product_id`)
    REFERENCES `Airport`.`products` (`product_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Airport`.`departure_arrival`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airport`.`departure_arrival` (
  `departure_arrival_id` VARCHAR(45) NOT NULL,
  `departure_airport` VARCHAR(45) CHARACTER SET 'utf8mb3' NOT NULL,
  `arrival_airport` VARCHAR(45) NOT NULL,
  `reward_miles` DECIMAL(10,2) NOT NULL,
  `flight_distance` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`departure_arrival_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Airport`.`flight_plans`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airport`.`flight_plans` (
  `plan_id` VARCHAR(45) NOT NULL,
  `season_code` VARCHAR(45) NOT NULL,
  `available_date` DATE NOT NULL,
  `departure_arrival_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`plan_id`),
  INDEX `fk_flight_plans_departure_arrival1_idx` (`departure_arrival_id` ASC) VISIBLE,
  CONSTRAINT `fk_flight_plans_departure_arrival1`
    FOREIGN KEY (`departure_arrival_id`)
    REFERENCES `Airport`.`departure_arrival` (`departure_arrival_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Airport`.`air_tickets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airport`.`air_tickets` (
  `product_id` VARCHAR(45) NOT NULL,
  `ticket_id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) CHARACTER SET 'utf8mb3' NOT NULL,
  `flight_plan_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ticket_id`, `product_id`),
  INDEX `fk_air_tickets_products1_idx` (`product_id` ASC) VISIBLE,
  INDEX `fk_air_tickets_flight_plans1_idx` (`flight_plan_id` ASC) VISIBLE,
  CONSTRAINT `fk_air_tickets_flight_plans1`
    FOREIGN KEY (`flight_plan_id`)
    REFERENCES `Airport`.`flight_plans` (`plan_id`),
  CONSTRAINT `fk_air_tickets_products1`
    FOREIGN KEY (`product_id`)
    REFERENCES `Airport`.`products` (`product_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Airport`.`airport`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airport`.`airport` (
  `airport_id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `location` VARCHAR(100) NOT NULL,
  `timezone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`airport_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Airport`.`atc_advisories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airport`.`atc_advisories` (
  `advisory_id` VARCHAR(45) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `issue_date` DATETIME NOT NULL,
  PRIMARY KEY (`advisory_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Airport`.`atc_advisory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airport`.`atc_advisory` (
  `plan_id` VARCHAR(45) NOT NULL,
  `advisory_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`plan_id`, `advisory_id`),
  INDEX `fk_flight_plans_has_atc_advisories_atc_advisories1_idx` (`advisory_id` ASC) VISIBLE,
  INDEX `fk_flight_plans_has_atc_advisories_flight_plans1_idx` (`plan_id` ASC) VISIBLE,
  CONSTRAINT `fk_flight_plans_has_atc_advisories_atc_advisories1`
    FOREIGN KEY (`advisory_id`)
    REFERENCES `Airport`.`atc_advisories` (`advisory_id`),
  CONSTRAINT `fk_flight_plans_has_atc_advisories_flight_plans1`
    FOREIGN KEY (`plan_id`)
    REFERENCES `Airport`.`flight_plans` (`plan_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Airport`.`combined_products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airport`.`combined_products` (
  `product_id` VARCHAR(45) NOT NULL,
  `combined_product_id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) CHARACTER SET 'utf8mb3' NOT NULL,
  PRIMARY KEY (`combined_product_id`, `product_id`),
  INDEX `fk_combined_products_products1` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_combined_products_products1`
    FOREIGN KEY (`product_id`)
    REFERENCES `Airport`.`products` (`product_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Airport`.`combined_product_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airport`.`combined_product_details` (
  `product_detail_id` VARCHAR(45) NOT NULL,
  `product_id` VARCHAR(45) NOT NULL,
  `combined_product_id` VARCHAR(45) NOT NULL,
  `ticket_id` VARCHAR(45) NULL,
  `service_id` VARCHAR(45) NULL,
  `affiliated_product_id` VARCHAR(45) NULL,
  `accessory_id` VARCHAR(45) NULL,
  PRIMARY KEY (`product_detail_id`, `product_id`, `combined_product_id`),
  INDEX `fk_combined_product_details_air_tickets1_idx` (`ticket_id` ASC) VISIBLE,
  INDEX `fk_combined_product_details_additional_services1_idx` (`service_id` ASC) VISIBLE,
  INDEX `fk_combined_product_details_affiliated_products1_idx` (`affiliated_product_id` ASC) VISIBLE,
  INDEX `fk_combined_product_details_accessories1_idx` (`accessory_id` ASC) VISIBLE,
  INDEX `fk_combined_product_details_combined_products1_idx` (`combined_product_id` ASC, `product_id` ASC) VISIBLE,
  CONSTRAINT `fk_combined_product_details_accessories1`
    FOREIGN KEY (`accessory_id`)
    REFERENCES `Airport`.`accessories` (`accessory_id`),
  CONSTRAINT `fk_combined_product_details_additional_services1`
    FOREIGN KEY (`service_id`)
    REFERENCES `Airport`.`additional_services` (`service_id`),
  CONSTRAINT `fk_combined_product_details_affiliated_products1`
    FOREIGN KEY (`affiliated_product_id`)
    REFERENCES `Airport`.`affiliated_products` (`affiliated_product_id`),
  CONSTRAINT `fk_combined_product_details_air_tickets1`
    FOREIGN KEY (`ticket_id`)
    REFERENCES `Airport`.`air_tickets` (`ticket_id`),
  CONSTRAINT `fk_combined_product_details_combined_products1`
    FOREIGN KEY (`combined_product_id` , `product_id`)
    REFERENCES `Airport`.`combined_products` (`combined_product_id` , `product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Airport`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airport`.`customer` (
  `customer_id` VARCHAR(45) NOT NULL,
  `name` NVARCHAR(45) NOT NULL,
  `age` INT NOT NULL,
  `gender` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Airport`.`customer_identification`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airport`.`customer_identification` (
  `identification_id` VARCHAR(45) NOT NULL,
  `customer_id` VARCHAR(45) NOT NULL,
  `customer_type` INT NOT NULL,
  `resident_number` VARCHAR(45) NOT NULL,
  `passport_number` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`identification_id`, `customer_id`),
  INDEX `fk_customer_identification_customer1_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_customer_identification_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `Airport`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Airport`.`corporate_customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airport`.`corporate_customer` (
  `customer_id` VARCHAR(45) NOT NULL,
  `corporate_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`customer_id`),
  CONSTRAINT `fk_corporate_customer_customer_identification1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `Airport`.`customer_identification` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Airport`.`crew_groups`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airport`.`crew_groups` (
  `group_id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) CHARACTER SET 'utf8mb3' NOT NULL,
  PRIMARY KEY (`group_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Airport`.`crews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airport`.`crews` (
  `crew_id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) CHARACTER SET 'utf8mb3' NOT NULL,
  `position` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`crew_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Airport`.`crew_group`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airport`.`crew_group` (
  `crew_id` VARCHAR(45) NOT NULL,
  `group_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`crew_id`, `group_id`),
  INDEX `fk_crew_groups_has_crews_crews1_idx` (`crew_id` ASC) VISIBLE,
  INDEX `fk_crew_groups_has_crews_crew_groups1_idx` (`group_id` ASC) VISIBLE,
  CONSTRAINT `fk_crew_groups_has_crews_crew_groups1`
    FOREIGN KEY (`group_id`)
    REFERENCES `Airport`.`crew_groups` (`group_id`),
  CONSTRAINT `fk_crew_groups_has_crews_crews1`
    FOREIGN KEY (`crew_id`)
    REFERENCES `Airport`.`crews` (`crew_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Airport`.`crew_schedules`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airport`.`crew_schedules` (
  `crew_id` VARCHAR(45) NOT NULL,
  `flight_plan_id` VARCHAR(45) NOT NULL,
  `schedule_date` DATE NOT NULL,
  PRIMARY KEY (`crew_id`, `flight_plan_id`),
  INDEX `fk_crew_schedules_crews1_idx` (`crew_id` ASC) VISIBLE,
  INDEX `fk_crew_schedules_flight_plans1_idx` (`flight_plan_id` ASC) VISIBLE,
  CONSTRAINT `fk_crew_schedules_crews1`
    FOREIGN KEY (`crew_id`)
    REFERENCES `Airport`.`crews` (`crew_id`),
  CONSTRAINT `fk_crew_schedules_flight_plans1`
    FOREIGN KEY (`flight_plan_id`)
    REFERENCES `Airport`.`flight_plans` (`plan_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Airport`.`flight_paths`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airport`.`flight_paths` (
  `departure_arrival_id` VARCHAR(45) NOT NULL,
  `departure_airport` VARCHAR(45) NOT NULL,
  `arrival_airport` VARCHAR(45) NOT NULL,
  `distance` DECIMAL(10,2) NOT NULL,
  `sequence` INT NOT NULL,
  PRIMARY KEY (`departure_arrival_id`),
  CONSTRAINT `fk_flight_paths_departure_arrival1`
    FOREIGN KEY (`departure_arrival_id`)
    REFERENCES `Airport`.`departure_arrival` (`departure_arrival_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Airport`.`individual_customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airport`.`individual_customer` (
  `customer_id` VARCHAR(45) NOT NULL,
  `membership_type` INT NOT NULL,
  PRIMARY KEY (`customer_id`),
  CONSTRAINT `fk_individual_customer_customer_identification1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `Airport`.`customer_identification` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Airport`.`pnr`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airport`.`pnr` (
  `pnr_id` VARCHAR(45) NOT NULL,
  `customer_id` VARCHAR(45) NOT NULL,
  `airlines_name` VARCHAR(45) NOT NULL,
  `reservation_date` DATETIME NOT NULL,
  `departure_city` VARCHAR(45) NOT NULL,
  `destination_city` VARCHAR(45) NOT NULL,
  `departure_date` DATETIME NOT NULL,
  `arrival_date` DATETIME NOT NULL,
  `seat_class` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`pnr_id`),
  INDEX `fk_pnr_customer1_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_pnr_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `Airport`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Airport`.`pax`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airport`.`pax` (
  `pax_id` VARCHAR(45) NOT NULL,
  `pnr_id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `age` VARCHAR(45) NOT NULL,
  `gender` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`pax_id`, `pnr_id`),
  CONSTRAINT `fk_pax_pnr1`
    FOREIGN KEY (`pnr_id`)
    REFERENCES `Airport`.`pnr` (`pnr_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Airport`.`preferred_flight_information`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airport`.`preferred_flight_information` (
  `preferred_information_id` VARCHAR(45) NOT NULL,
  `customer_id` VARCHAR(45) NOT NULL,
  `flight_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`preferred_information_id`, `customer_id`),
  CONSTRAINT `fk_preferred_flight_information_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `Airport`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Airport`.`regular_member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airport`.`regular_member` (
  `individual_customer_id` VARCHAR(45) NOT NULL,
  INDEX `fk_regular_member_individual_customer1_idx` (`individual_customer_id` ASC) VISIBLE,
  PRIMARY KEY (`individual_customer_id`),
  CONSTRAINT `fk_regular_member_individual_customer1`
    FOREIGN KEY (`individual_customer_id`)
    REFERENCES `Airport`.`individual_customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Airport`.`seg`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airport`.`seg` (
  `seg_id` VARCHAR(45) NOT NULL,
  `pnr_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`seg_id`, `pnr_id`),
  INDEX `fk_seg_pnr1_idx` (`pnr_id` ASC) VISIBLE,
  CONSTRAINT `fk_seg_pnr1`
    FOREIGN KEY (`pnr_id`)
    REFERENCES `Airport`.`pnr` (`pnr_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Airport`.`simple_member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airport`.`simple_member` (
  `individual_customer_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`individual_customer_id`),
  INDEX `fk_simple_member_individual_customer1_idx` (`individual_customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_simple_member_individual_customer1`
    FOREIGN KEY (`individual_customer_id`)
    REFERENCES `Airport`.`individual_customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Airport`.`ssr`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airport`.`ssr` (
  `ssr_id` VARCHAR(45) NOT NULL,
  `seg_id` VARCHAR(45) NOT NULL,
  `pax_id` VARCHAR(45) NOT NULL,
  `inflightdining` INT NOT NULL,
  `loungeaccess` INT NOT NULL,
  `priorityboarding` INT NOT NULL,
  PRIMARY KEY (`ssr_id`),
  INDEX `fk_ssr_seg1_idx` (`seg_id` ASC) VISIBLE,
  INDEX `fk_ssr_pax1_idx` (`pax_id` ASC) VISIBLE,
  CONSTRAINT `fk_ssr_seg1`
    FOREIGN KEY (`seg_id`)
    REFERENCES `Airport`.`seg` (`seg_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ssr_pax1`
    FOREIGN KEY (`pax_id`)
    REFERENCES `Airport`.`pax` (`pax_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Airport`.`corporate_employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airport`.`corporate_employee` (
  `corporate_id` VARCHAR(45) NOT NULL,
  `individual_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`corporate_id`, `individual_id`),
  INDEX `fk_corporate_employee_corporate_customer1_idx` (`corporate_id` ASC) VISIBLE,
  INDEX `fk_corporate_employee_individual_customer1_idx` (`individual_id` ASC) VISIBLE,
  CONSTRAINT `fk_corporate_employee_corporate_customer1`
    FOREIGN KEY (`corporate_id`)
    REFERENCES `Airport`.`corporate_customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_corporate_employee_individual_customer1`
    FOREIGN KEY (`individual_id`)
    REFERENCES `Airport`.`individual_customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Airport`.`corporate_benefit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airport`.`corporate_benefit` (
  `corporate_benefit_id` VARCHAR(45) NOT NULL,
  `corporate_id` VARCHAR(45) NOT NULL,
  `benefit` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`corporate_benefit_id`, `corporate_id`),
  INDEX `fk_corporate_benefit_corporate_customer1_idx` (`corporate_id` ASC) VISIBLE,
  CONSTRAINT `fk_corporate_benefit_corporate_customer1`
    FOREIGN KEY (`corporate_id`)
    REFERENCES `Airport`.`corporate_customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Airport`.`additional_service_reservation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airport`.`additional_service_reservation` (
  `service_id` VARCHAR(45) NOT NULL,
  `product_id` VARCHAR(45) NOT NULL,
  `pax_id` VARCHAR(45) NOT NULL,
  `seg_id` VARCHAR(45) NOT NULL,
  INDEX `fk_additional_service_reservation_products1_idx` (`product_id` ASC) VISIBLE,
  PRIMARY KEY (`service_id`),
  INDEX `fk_additional_service_reservation_pax1_idx` (`pax_id` ASC) VISIBLE,
  INDEX `fk_additional_service_reservation_seg1_idx` (`seg_id` ASC) VISIBLE,
  CONSTRAINT `fk_additional_service_reservation_products1`
    FOREIGN KEY (`product_id`)
    REFERENCES `Airport`.`products` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_additional_service_reservation_pax1`
    FOREIGN KEY (`pax_id`)
    REFERENCES `Airport`.`pax` (`pax_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_additional_service_reservation_seg1`
    FOREIGN KEY (`seg_id`)
    REFERENCES `Airport`.`seg` (`seg_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Airport`.`terminal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airport`.`terminal` (
  `terminal_id` VARCHAR(45) NOT NULL,
  `airport_airport_id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`terminal_id`),
  INDEX `fk_terminal_airport1_idx` (`airport_airport_id` ASC) VISIBLE,
  CONSTRAINT `fk_terminal_airport1`
    FOREIGN KEY (`airport_airport_id`)
    REFERENCES `Airport`.`airport` (`airport_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Airport`.`gate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airport`.`gate` (
  `gate_id` VARCHAR(45) NOT NULL,
  `terminal_id` VARCHAR(45) NOT NULL,
  `number` INT NOT NULL,
  PRIMARY KEY (`gate_id`),
  INDEX `fk_gate_terminal1_idx` (`terminal_id` ASC) VISIBLE,
  CONSTRAINT `fk_gate_terminal1`
    FOREIGN KEY (`terminal_id`)
    REFERENCES `Airport`.`terminal` (`terminal_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Airport`.`airport_atc_advisory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airport`.`airport_atc_advisory` (
  `advisory_id` VARCHAR(45) NOT NULL,
  `airport_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`advisory_id`, `airport_id`),
  INDEX `fk_atc_advisories_has_airport_airport1_idx` (`airport_id` ASC) VISIBLE,
  INDEX `fk_atc_advisories_has_airport_atc_advisories1_idx` (`advisory_id` ASC) VISIBLE,
  CONSTRAINT `fk_atc_advisories_has_airport_atc_advisories1`
    FOREIGN KEY (`advisory_id`)
    REFERENCES `Airport`.`atc_advisories` (`advisory_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_atc_advisories_has_airport_airport1`
    FOREIGN KEY (`airport_id`)
    REFERENCES `Airport`.`airport` (`airport_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Airport`.`airport_has_airline`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airport`.`airport_has_airline` (
  `airport_id` VARCHAR(45) NOT NULL,
  `airline_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`airport_id`, `airline_id`),
  INDEX `fk_airport_has_airline_airline1_idx` (`airline_id` ASC) VISIBLE,
  INDEX `fk_airport_has_airline_airport1_idx` (`airport_id` ASC) VISIBLE,
  CONSTRAINT `fk_airport_has_airline_airport1`
    FOREIGN KEY (`airport_id`)
    REFERENCES `Airport`.`airport` (`airport_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_airport_has_airline_airline1`
    FOREIGN KEY (`airline_id`)
    REFERENCES `Airport`.`airline` (`airline_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Airport`.`fleet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Airport`.`fleet` (
  `fleet_id` VARCHAR(45) NOT NULL,
  `airline_id` VARCHAR(45) NOT NULL,
  `model` VARCHAR(45) NOT NULL,
  `capacity` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`fleet_id`),
  INDEX `fk_fleet_airline1_idx` (`airline_id` ASC) VISIBLE,
  CONSTRAINT `fk_fleet_airline1`
    FOREIGN KEY (`airline_id`)
    REFERENCES `Airport`.`airline` (`airline_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
