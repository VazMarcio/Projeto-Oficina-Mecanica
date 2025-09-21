-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Oficina_Mecânica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Oficina_Mecânica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Oficina_Mecânica` DEFAULT CHARACTER SET utf8 ;
USE `Oficina_Mecânica` ;

-- -----------------------------------------------------
-- Table `Oficina_Mecânica`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina_Mecânica`.`Cliente` (
  `idCliente` INT NOT NULL,
  `nome` VARCHAR(100) NULL,
  `endereco` VARCHAR(150) NULL,
  `telefone` VARCHAR(20) NULL,
  `email` VARCHAR(100) NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Oficina_Mecânica`.`Ordem_Serviço (OS)`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina_Mecânica`.`Ordem_Serviço (OS)` (
  `idOs` INT NOT NULL,
  `numeroOs` VARCHAR(20) NOT NULL,
  `valorTotal` DECIMAL(10,2) NOT NULL,
  `status` VARCHAR(20) NOT NULL,
  `autorizada` TINYINT NOT NULL,
  `dataEmissao` DATE NOT NULL,
  `dataConclusao` DATE NOT NULL,
  PRIMARY KEY (`idOs`),
  UNIQUE INDEX `numeroOs_UNIQUE` (`numeroOs` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Oficina_Mecânica`.`Veiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina_Mecânica`.`Veiculo` (
  `idVeiculo` INT NOT NULL,
  `placa` VARCHAR(10) NOT NULL,
  `marca` VARCHAR(50) NOT NULL,
  `modelo` VARCHAR(50) NOT NULL,
  `ano` INT NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Ordem_Serviço (OS)_idOs` INT NOT NULL,
  `Ordem_Serviço (OS)_idOs1` INT NOT NULL,
  PRIMARY KEY (`idVeiculo`),
  UNIQUE INDEX `placa_UNIQUE` (`placa` ASC) VISIBLE,
  INDEX `fk_Veiculo_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  INDEX `fk_Veiculo_Ordem_Serviço (OS)1_idx` (`Ordem_Serviço (OS)_idOs` ASC) VISIBLE,
  INDEX `fk_Veiculo_Ordem_Serviço (OS)2_idx` (`Ordem_Serviço (OS)_idOs1` ASC) VISIBLE,
  CONSTRAINT `fk_Veiculo_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `Oficina_Mecânica`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Veiculo_Ordem_Serviço (OS)1`
    FOREIGN KEY (`Ordem_Serviço (OS)_idOs`)
    REFERENCES `Oficina_Mecânica`.`Ordem_Serviço (OS)` (`idOs`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Veiculo_Ordem_Serviço (OS)2`
    FOREIGN KEY (`Ordem_Serviço (OS)_idOs1`)
    REFERENCES `Oficina_Mecânica`.`Ordem_Serviço (OS)` (`idOs`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Oficina_Mecânica`.`Mecânico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina_Mecânica`.`Mecânico` (
  `idMecanico` INT NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `endereco` VARCHAR(150) NOT NULL,
  `especialidade` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idMecanico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Oficina_Mecânica`.`Equipe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina_Mecânica`.`Equipe` (
  `idEquipe` INT NOT NULL,
  `nome_equipe` VARCHAR(50) NULL,
  `Ordem_Serviço (OS)_idOs` INT NOT NULL,
  `Ordem_Serviço (OS)_idOs1` INT NOT NULL,
  PRIMARY KEY (`idEquipe`),
  INDEX `fk_Equipe_Ordem_Serviço (OS)1_idx` (`Ordem_Serviço (OS)_idOs` ASC) VISIBLE,
  INDEX `fk_Equipe_Ordem_Serviço (OS)2_idx` (`Ordem_Serviço (OS)_idOs1` ASC) VISIBLE,
  CONSTRAINT `fk_Equipe_Ordem_Serviço (OS)1`
    FOREIGN KEY (`Ordem_Serviço (OS)_idOs`)
    REFERENCES `Oficina_Mecânica`.`Ordem_Serviço (OS)` (`idOs`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Equipe_Ordem_Serviço (OS)2`
    FOREIGN KEY (`Ordem_Serviço (OS)_idOs1`)
    REFERENCES `Oficina_Mecânica`.`Ordem_Serviço (OS)` (`idOs`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Oficina_Mecânica`.`Equipe_Mecânico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina_Mecânica`.`Equipe_Mecânico` (
  `idEquipe` INT NOT NULL,
  `idMecanico` INT NOT NULL,
  `Equipe_Mecânico_idEquipe` INT NOT NULL,
  `Equipe_Mecânico_idMecanico` INT NOT NULL,
  `Mecânico_idMecanico` INT NOT NULL,
  PRIMARY KEY (`idEquipe`, `idMecanico`),
  INDEX `fk_Equipe_has_Mecânico_Mecânico1_idx` (`idMecanico` ASC) VISIBLE,
  INDEX `fk_Equipe_Mecânico_Equipe_Mecânico1_idx` (`Equipe_Mecânico_idEquipe` ASC, `Equipe_Mecânico_idMecanico` ASC) VISIBLE,
  INDEX `fk_Equipe_Mecânico_Mecânico1_idx` (`Mecânico_idMecanico` ASC) VISIBLE,
  CONSTRAINT `fk_Equipe_has_Mecânico_Mecânico1`
    FOREIGN KEY (`idMecanico`)
    REFERENCES `Oficina_Mecânica`.`Mecânico` (`idMecanico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Equipe_Mecânico_Equipe_Mecânico1`
    FOREIGN KEY (`Equipe_Mecânico_idEquipe` , `Equipe_Mecânico_idMecanico`)
    REFERENCES `Oficina_Mecânica`.`Equipe_Mecânico` (`idEquipe` , `idMecanico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Equipe_Mecânico_Mecânico1`
    FOREIGN KEY (`Mecânico_idMecanico`)
    REFERENCES `Oficina_Mecânica`.`Mecânico` (`idMecanico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Oficina_Mecânica`.`Serviço`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina_Mecânica`.`Serviço` (
  `idServico` INT NOT NULL,
  `descricao` VARCHAR(100) NULL,
  `valorMaodeObra` DECIMAL(10,2) NULL,
  PRIMARY KEY (`idServico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Oficina_Mecânica`.`Peça`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina_Mecânica`.`Peça` (
  `idPeca` INT NOT NULL,
  `descricao` VARCHAR(100) NULL,
  `valorUnitario` DECIMAL(10,2) NOT NULL,
  `Ordem_Serviço (OS)_idOs` INT NOT NULL,
  PRIMARY KEY (`idPeca`),
  INDEX `fk_Peça_Ordem_Serviço (OS)1_idx` (`Ordem_Serviço (OS)_idOs` ASC) VISIBLE,
  CONSTRAINT `fk_Peça_Ordem_Serviço (OS)1`
    FOREIGN KEY (`Ordem_Serviço (OS)_idOs`)
    REFERENCES `Oficina_Mecânica`.`Ordem_Serviço (OS)` (`idOs`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Oficina_Mecânica`.`Os_Serviço`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina_Mecânica`.`Os_Serviço` (
  `idServico` INT NOT NULL,
  `quantidade` INT NOT NULL,
  `valorTotal` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`idServico`),
  INDEX `fk_Ordem_Serviço (OS)_has_Serviço_Serviço1_idx` (`idServico` ASC) VISIBLE,
  CONSTRAINT `fk_Ordem_Serviço (OS)_has_Serviço_Serviço1`
    FOREIGN KEY (`idServico`)
    REFERENCES `Oficina_Mecânica`.`Serviço` (`idServico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Oficina_Mecânica`.`Os_Peça`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Oficina_Mecânica`.`Os_Peça` (
  `idOs` INT NOT NULL,
  `idPeca` INT NOT NULL,
  `quantidade` INT NOT NULL,
  `valorTotal` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`idOs`, `idPeca`),
  INDEX `fk_Ordem_Serviço (OS)_has_Peça_Peça1_idx` (`idPeca` ASC) VISIBLE,
  INDEX `fk_Ordem_Serviço (OS)_has_Peça_Ordem_Serviço (OS)1_idx` (`idOs` ASC) VISIBLE,
  CONSTRAINT `fk_Ordem_Serviço (OS)_has_Peça_Ordem_Serviço (OS)1`
    FOREIGN KEY (`idOs`)
    REFERENCES `Oficina_Mecânica`.`Ordem_Serviço (OS)` (`idOs`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ordem_Serviço (OS)_has_Peça_Peça1`
    FOREIGN KEY (`idPeca`)
    REFERENCES `Oficina_Mecânica`.`Peça` (`idPeca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
