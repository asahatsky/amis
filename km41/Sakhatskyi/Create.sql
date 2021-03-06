CREATE TABLE "MATERIAL" (
  "ID" NUMBER(10) CONSTRAINT "PK_MATERIAL" PRIMARY KEY,
  "NAME" VARCHAR2(100 CHAR) NOT NULL,
  "DESCRIPTION" VARCHAR2(500 CHAR),
  "RECYCLEBIN" VARCHAR2(1000 CHAR) NOT NULL
);

CREATE SEQUENCE "MATERIAL_SEQ" NOCACHE;

CREATE TRIGGER "MATERIAL_BI"
  BEFORE INSERT ON "MATERIAL"
  FOR EACH ROW
BEGIN
  IF :NEW."ID" IS NULL THEN
    SELECT "MATERIAL_SEQ".NEXTVAL INTO :NEW."ID" FROM DUAL;
  END IF;
END;;

CREATE TABLE "USER" (
  "ID" NUMBER(10) CONSTRAINT "PK_USER" PRIMARY KEY,
  "EMAIL" VARCHAR2(50 CHAR) UNIQUE NOT NULL,
  "LOGIN" VARCHAR2(30 CHAR) UNIQUE NOT NULL,
  "PASSWORD" VARCHAR2(30 CHAR) UNIQUE NOT NULL
);

CREATE SEQUENCE "USER_SEQ" NOCACHE;

CREATE TRIGGER "USER_BI"
  BEFORE INSERT ON "USER"
  FOR EACH ROW
BEGIN
  IF :NEW."ID" IS NULL THEN
    SELECT "USER_SEQ".NEXTVAL INTO :NEW."ID" FROM DUAL;
  END IF;
END;;

CREATE TABLE "RECYCLEHISTORY" (
  "ID" NUMBER(10) CONSTRAINT "PK_RECYCLEHISTORY" PRIMARY KEY,
  "USER" NUMBER(10) NOT NULL
);

CREATE INDEX "IDX_RECYCLEHISTORY__USER" ON "RECYCLEHISTORY" ("USER");

ALTER TABLE "RECYCLEHISTORY" ADD CONSTRAINT "FK_RECYCLEHISTORY__USER" FOREIGN KEY ("USER") REFERENCES "USER" ("ID");

CREATE SEQUENCE "RECYCLEHISTORY_SEQ" NOCACHE;

CREATE TRIGGER "RECYCLEHISTORY_BI"
  BEFORE INSERT ON "RECYCLEHISTORY"
  FOR EACH ROW
BEGIN
  IF :NEW."ID" IS NULL THEN
    SELECT "RECYCLEHISTORY_SEQ".NEXTVAL INTO :NEW."ID" FROM DUAL;
  END IF;
END;;

CREATE TABLE "PRODUCTTOHISTORY" (
  "ID" NUMBER(10) CONSTRAINT "PK_PRODUCTTOHISTORY" PRIMARY KEY,
  "RECYCLE_HISTORY" NUMBER(10) NOT NULL
);

CREATE INDEX "IDX_PRODUCTTOHISTORY__2a1202e0" ON "PRODUCTTOHISTORY" ("RECYCLE_HISTORY");

ALTER TABLE "PRODUCTTOHISTORY" ADD CONSTRAINT "FK_PRODUCTTOHISTORY___2f610164" FOREIGN KEY ("RECYCLE_HISTORY") REFERENCES "RECYCLEHISTORY" ("ID");

CREATE SEQUENCE "PRODUCTTOHISTORY_SEQ" NOCACHE;

CREATE TRIGGER "PRODUCTTOHISTORY_BI"
  BEFORE INSERT ON "PRODUCTTOHISTORY"
  FOR EACH ROW
BEGIN
  IF :NEW."ID" IS NULL THEN
    SELECT "PRODUCTTOHISTORY_SEQ".NEXTVAL INTO :NEW."ID" FROM DUAL;
  END IF;
END;;

CREATE TABLE "PRODUCT" (
  "ID" NUMBER(10) CONSTRAINT "PK_PRODUCT" PRIMARY KEY,
  "PRODUCT_TO_HISTORY" NUMBER(10),
  "MATERIAL" NUMBER(10) NOT NULL,
  "NAME" VARCHAR2(50 CHAR) NOT NULL,
  "PAYMENT" NUMBER NOT NULL,
  "DESCRIPTION" VARCHAR2(1000 CHAR)
);

CREATE INDEX "IDX_PRODUCT__MATERIAL" ON "PRODUCT" ("MATERIAL");

CREATE INDEX "IDX_PRODUCT__PRODUCT__77aa0bec" ON "PRODUCT" ("PRODUCT_TO_HISTORY");

ALTER TABLE "PRODUCT" ADD CONSTRAINT "FK_PRODUCT__MATERIAL" FOREIGN KEY ("MATERIAL") REFERENCES "MATERIAL" ("ID");

ALTER TABLE "PRODUCT" ADD CONSTRAINT "FK_PRODUCT__PRODUCT_TO_HISTORY" FOREIGN KEY ("PRODUCT_TO_HISTORY") REFERENCES "PRODUCTTOHISTORY" ("ID");

CREATE SEQUENCE "PRODUCT_SEQ" NOCACHE;

CREATE TRIGGER "PRODUCT_BI"
  BEFORE INSERT ON "PRODUCT"
  FOR EACH ROW
BEGIN
  IF :NEW."ID" IS NULL THEN
    SELECT "PRODUCT_SEQ".NEXTVAL INTO :NEW."ID" FROM DUAL;
  END IF;
END;;

CREATE TABLE "ROLE" (
  "USER" NUMBER(10) CONSTRAINT "PK_ROLE" PRIMARY KEY,
  "ROLENAME" VARCHAR2(30 CHAR) DEFAULT 'admin, user' NOT NULL
);

ALTER TABLE "ROLE" ADD CONSTRAINT "FK_ROLE__USER" FOREIGN KEY ("USER") REFERENCES "USER" ("ID")