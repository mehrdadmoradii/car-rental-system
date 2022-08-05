DROP TABLE cr_car CASCADE CONSTRAINTS;
DROP TABLE cr_dealership CASCADE CONSTRAINTS;
DROP TABLE cr_location CASCADE CONSTRAINTS;
DROP TABLE cr_dealership_manager CASCADE CONSTRAINTS;
DROP TABLE cr_reservation CASCADE CONSTRAINTS;
DROP TABLE cr_user CASCADE CONSTRAINTS;

DROP SEQUENCE cr_car_seq;
DROP SEQUENCE cr_dealership_seq;
DROP SEQUENCE cr_location_seq;
DROP SEQUENCE cr_dealership_manager_seq;
DROP SEQUENCE cr_reservation_seq;
DROP SEQUENCE cr_user_seq;

DROP INDEX cr_car_index;
DROP INDEX cr_reservation_index;

DROP VIEW reservation_view;

-- *******************************************************************
-- ***********************  Defining Sequences ***********************
-- *******************************************************************

CREATE SEQUENCE cr_user_seq
    START WITH 1000
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

CREATE SEQUENCE cr_reservation_seq
    START WITH 1000
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

CREATE SEQUENCE cr_car_seq
    START WITH 1000
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

CREATE SEQUENCE cr_dealership_seq
    START WITH 1000
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

CREATE SEQUENCE cr_location_seq
    START WITH 1000
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

CREATE SEQUENCE cr_dealership_manager_seq
    START WITH 1000
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- *******************************************************************
-- ******************** Initial table definitions ********************
-- *******************************************************************

CREATE TABLE cr_user (
    idUser number(5) DEFAULT cr_user_seq.nextval,
    FirstName varchar2(60),
    LastName varchar2(60),
    Country varchar2(60),
    Username varchar2(60) UNIQUE NOT NULL,
    Password varchar2(30) NOT NULL,
    IsEnabled char(1) default 'N',
    CONSTRAINT
        cr_user_pk PRIMARY KEY (idUser)
);

CREATE TABLE cr_reservation (
    idReservation number(5) DEFAULT cr_reservation_seq.nextval,
    idUser number(5),
    idCar number(5),
    StartDate date DEFAULT SYSDATE,
    EndDate date,
    CONSTRAINT
        cr_reservation_pk PRIMARY KEY (idReservation)
);

CREATE TABLE cr_car (
    idCar number(5) DEFAULT cr_user_seq.nextval,
    Make varchar2(60),
    Model varchar2(60),
    Year number(4),
    idDealership number(5),
    isAvailable char(1),
    rent_rate number(4),
    CONSTRAINT
        cr_car_pk PRIMARY KEY (idCar)
);

CREATE TABLE cr_dealership (
    idDealership number(5) DEFAULT cr_dealership_seq.nextval,
    Name varchar2(60),
    idLocation number(5),
    CONSTRAINT
        cr_dealership_pk PRIMARY KEY (idDealership)
);

CREATE TABLE cr_location (
    idLocation number(5) DEFAULT cr_location_seq.nextval,
    City varchar2(60),
    Country varchar2(60),
    CONSTRAINT
        cr_location_pk PRIMARY KEY (idLocation)
);

CREATE TABLE cr_dealership_manager (
    idManager number(5) DEFAULT cr_dealership_manager_seq.nextval,
    Name varchar2(60),
    idDealership number(5),
    CONSTRAINT
        cr_dealership_manager_pk PRIMARY KEY (idManager)
);

-- *******************************************************************
-- *****************  Adding foreign key constraints *****************
-- *******************************************************************

ALTER TABLE cr_reservation
ADD CONSTRAINT cr_reservation_fk_user
    FOREIGN KEY (idUser)
    REFERENCES cr_user(idUser);

ALTER TABLE cr_reservation
ADD CONSTRAINT cr_reservation_fk_car
    FOREIGN KEY (idCar)
    REFERENCES cr_car(idCar);

ALTER TABLE cr_car
ADD CONSTRAINT cr_car_fk_dealership
    FOREIGN KEY (idDealership)
    REFERENCES cr_dealership(idDealership);

ALTER TABLE cr_dealership
ADD CONSTRAINT cr_dealership_fk_loc
    FOREIGN KEY (idLocation)
    REFERENCES cr_location(idLocation);

ALTER TABLE cr_dealership_manager
ADD CONSTRAINT cr_dealership_manager_fk
    FOREIGN KEY (idDealership)
    REFERENCES cr_dealership(idDealership);

-- *******************************************************************
-- *************************** Indexes *******************************
-- *******************************************************************

CREATE INDEX cr_car_index
    ON cr_car(idCar, idDealership, isAvailable);

CREATE INDEX cr_reservation_index
    ON cr_reservation(idUser, idCar, ENDDATE);

-- *******************************************************************
-- ******************** Initial data population **********************
-- *******************************************************************

INSERT INTO cr_location (idLocation, City, Country) VALUES (1, 'Toronto', 'Canada');
INSERT INTO cr_location (idLocation, City, Country) VALUES (2, 'London', 'UK');
INSERT INTO cr_location (idLocation, City, Country) VALUES (3, 'New York', 'US');

INSERT INTO cr_dealership (idDealership, Name, idLocation) VALUES (1, 'Toronto dealership 1', 1);
INSERT INTO cr_dealership (idDealership, Name, idLocation) VALUES (2, 'Toronto car dealership', 1);
INSERT INTO cr_dealership (idDealership, Name, idLocation) VALUES (3, 'London dealership 1', 2);
INSERT INTO cr_dealership (idDealership, Name, idLocation) VALUES (4, 'New York dealership 1', 3);

INSERT INTO cr_dealership_manager (Name, idDealership) VALUES ('John Smith', 1);
INSERT INTO cr_dealership_manager (Name, idDealership) VALUES ('Brian Yu', 3);
INSERT INTO cr_dealership_manager (Name, idDealership) VALUES ('David Malan', 4);

INSERT INTO cr_car
    (idCar, Make, Model, Year, idDealership, isAvailable, rent_rate)
VALUES
    (1, 'Chevrolet', 'Spark', 2020, 1, 'Y', 60);
INSERT INTO cr_car
    (idCar, Make, Model, Year, idDealership, isAvailable, rent_rate)
VALUES
    (2, 'Hyundai', 'Accent', 2021, 1, 'N', 62);
INSERT INTO cr_car
    (idCar, Make, Model, Year, idDealership, isAvailable, rent_rate)
VALUES
    (3, 'Volkswagen', 'Golf', 2018, 1, 'N', 68);
INSERT INTO cr_car
    (idCar, Make, Model, Year, idDealership, isAvailable, rent_rate)
VALUES
    (4, 'Hyundai', 'Tucson', 2020, 1, 'Y', 99);
INSERT INTO cr_car
    (idCar, Make, Model, Year, idDealership, isAvailable, rent_rate)
VALUES
    (5, 'Peugeot', '5008', 2020, 3, 'Y', 240);
INSERT INTO cr_car
    (idCar, Make, Model, Year, idDealership, isAvailable, rent_rate)
VALUES
    (6, 'Citroen', 'Grand Picasso', 2020, 3, 'Y', 217);
INSERT INTO cr_car
    (idCar, Make, Model, Year, idDealership, isAvailable, rent_rate)
VALUES
    (7, 'Citroen', 'Grand Picasso', 2020, 3, 'N', 217);
INSERT INTO cr_car
    (idCar, Make, Model, Year, idDealership, isAvailable, rent_rate)
VALUES
    (8, 'Toyota', 'Camry', 2019, 4, 'N', 58);
INSERT INTO cr_car
    (idCar, Make, Model, Year, idDealership, isAvailable, rent_rate)
VALUES
    (9, 'Ford', 'Fiesta', 2019, 4, 'N', 48);
INSERT INTO cr_car
    (idCar, Make, Model, Year, idDealership, isAvailable, rent_rate)
VALUES
    (10, 'Kia', 'Soul', 2019, 4, 'N', 53);
INSERT INTO cr_car
    (idCar, Make, Model, Year, idDealership, isAvailable, rent_rate)
VALUES
    (11, 'Toyota', 'Corolla', 2019, 4, 'N', 58);
INSERT INTO cr_car
    (idCar, Make, Model, Year, idDealership, isAvailable, rent_rate)
VALUES
    (12, 'Volkswagen', 'Jetta', 2019, 4, 'N', 68);
INSERT INTO cr_car
    (idCar, Make, Model, Year, idDealership, isAvailable, rent_rate)
VALUES
    (13, 'Mazda', 'CX-5', 2019, 2, 'N', 78);

INSERT INTO cr_user
    (idUser, FirstName, LastName, Country, Username, Password, IsEnabled)
VALUES
    (1, 'Mehrdad', 'Moradizadeh', 'Canada', 'Mehrdad2001', '1234', 'Y');
INSERT INTO cr_user
    (idUser, FirstName, LastName, Country, Username, Password, IsEnabled)
VALUES
    (2, 'Sara', 'Jones', 'Mexico', 'Sara_jones', '4321', 'N');
INSERT INTO cr_user
    (idUser, FirstName, LastName, Country, Username, Password, IsEnabled)
VALUES
    (3, 'Matt', 'Smith', 'US', 'Mattew123', '6789', 'Y');
INSERT INTO cr_user
    (idUser, FirstName, LastName, Country, Username, Password, IsEnabled)
VALUES
    (4, 'John', 'Doe', 'France', 'John2389', 'abcdefg', 'N');


-- *******************************************************************
-- *************************** Procedures ****************************
-- *******************************************************************

CREATE or replace
PROCEDURE ACTIVATE_USER_ACCOUNT
    (p_user_id IN cr_user.idUser%TYPE)
AS
BEGIN
    UPDATE cr_user
    SET IsEnabled = 'Y'
    WHERE idUser = p_user_id;
    IF SQL%NOTFOUND THEN
        raise NO_DATA_FOUND;
    end if;
END;

CREATE or replace
PROCEDURE MAKE_RESERVATION
    (p_user_id IN cr_user.idUser%TYPE,
     p_car_id IN cr_car.idCar%TYPE,
     p_number_of_days IN NUMBER)
AS
BEGIN
    IF NOT is_user_account_activated(p_user_id) = 'Y' OR NOT is_car_available(p_car_id) = 'Y' THEN
        raise VALUE_ERROR;
    end if;
    INSERT INTO cr_reservation
        (idUser, idCar, EndDate)
    VALUES
        (p_user_id, p_car_id, SYSDATE+p_number_of_days);
END;

CREATE or replace
PROCEDURE CHANGE_CAR_AVAILABILITY
    (p_new_condition IN CHAR,
     p_car_id IN cr_car.idCar%TYPE)
as
BEGIN
    UPDATE cr_car
    SET isAvailable = p_new_condition
    WHERE idCar = p_car_id;
    IF SQL%NOTFOUND THEN
        raise NO_DATA_FOUND;
    end if;
end;

CREATE or REPLACE
PROCEDURE MAKE_CAR_AVAILABLE
    (p_car_id IN cr_car.idCar%TYPE)
as
BEGIN
    CHANGE_CAR_AVAILABILITY(
        p_new_condition => 'Y',
        p_car_id => p_car_id
    );
end;

CREATE or REPLACE
PROCEDURE MAKE_CAR_NOT_AVAILABLE
    (p_car_id IN cr_car.idCar%TYPE)
as
BEGIN
    CHANGE_CAR_AVAILABILITY(
        p_new_condition => 'N',
        p_car_id => p_car_id
    );
end;

-- *******************************************************************
-- **************************** Functions ****************************
-- *******************************************************************

CREATE or replace
FUNCTION remaining_days
    (p_reservation_id IN NUMBER)
    RETURN NUMBER
IS
    lv_remaining_days NUMBER;
BEGIN
    SELECT EndDate - SYSDATE
    INTO lv_remaining_days
    FROM cr_reservation
    WHERE idReservation = p_reservation_id;
    IF SQL%NOTFOUND THEN
        raise NO_DATA_FOUND;
    end if;
    return TRUNC(lv_remaining_days);
end;

CREATE or replace
FUNCTION is_user_exist
    (p_user_id IN cr_user.idUser%TYPE)
    RETURN CHAR
IS
    lv_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO lv_count
    FROM cr_user
    WHERE idUser = p_user_id;
    IF lv_count = 0 THEN
        return 'N';
    ELSE
        return 'Y';
    end if;
end;

CREATE or replace
FUNCTION is_car_exist
    (p_car_id IN cr_car.idCar%TYPE)
    RETURN CHAR
IS
    lv_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO lv_count
    FROM cr_car
    WHERE idCar = p_car_id;
    IF lv_count = 0 THEN
        return 'N';
    ELSE
        return 'Y';
    end if;
end;


CREATE or replace
FUNCTION is_car_available
    (p_car_id IN cr_car.idCar%TYPE)
    RETURN CHAR
IS
    lv_available CHAR;
BEGIN
    SELECT isAvailable
    INTO lv_available
    FROM cr_car
    WHERE cr_car.idCar = p_car_id;
    IF SQL%NOTFOUND THEN
        raise NO_DATA_FOUND;
    end if;
    return lv_available;
end;

CREATE or replace
FUNCTION is_user_account_activated
    (p_user_id IN cr_user.idUser%TYPE)
    RETURN CHAR
IS
    lv_activated CHAR;
BEGIN
    SELECT IsEnabled
    INTO lv_activated
    FROM cr_user
    WHERE cr_user.idUser = p_user_id;
    IF SQL%NOTFOUND THEN
        raise NO_DATA_FOUND;
    end if;
    return lv_activated;
end;


-- *******************************************************************
-- ***************************** Trigers *****************************
-- *******************************************************************

CREATE or replace TRIGGER after_reservation_insert
    AFTER INSERT ON cr_reservation
    FOR EACH ROW
BEGIN
    MAKE_CAR_NOT_AVAILABLE(:NEW.idCar);
end;

CREATE or replace TRIGGER after_reservation_delete
    BEFORE DELETE ON cr_reservation
    FOR EACH ROW
BEGIN
    MAKE_CAR_AVAILABLE(:OLD.idCar);
end;

-- *******************************************************************
-- ****************************** Views ******************************
-- *******************************************************************

CREATE VIEW reservation_view
AS
SELECT
       r.idReservation,
       r.EndDate,
       r.idUser user_id,
       u.FirstName || ' ' || u.LastName user_name,
       c.Make || ' ' || c.Model car_name,
       c.rent_rate rate
FROM
    cr_reservation r
        JOIN
        cr_user u
            ON r.idUser = u.idUser
        JOIN
        cr_car c
            ON r.idCar = c.idCar;

-- *******************************************************************
-- ************************** Exploration ****************************
-- *******************************************************************

-- select idCar, Make || ' ' || Model name, isAvailable from cr_car;
-- 
-- begin
--     MAKE_RESERVATION(1, 5, 7);
-- end;
-- 
-- select idCar, Make || ' ' || Model name, isAvailable from cr_car;
-- 
-- delete from cr_reservation where idUser = 1;
