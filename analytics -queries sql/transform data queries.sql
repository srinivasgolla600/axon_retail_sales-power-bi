ALTER TABLE `customers` ADD COLUMN `fullAddress` VARCHAR(255); #adding new column to customers table


-- Combine addressLine1 and addressLine2 into fullAddress.
UPDATE `customers`
SET `fullAddress` = 
    CASE 
        WHEN `addressLine2` IS NULL THEN `addressLine1`
        ELSE CONCAT(`addressLine1`, ', ', `addressLine2`)
    END
     WHERE `customerNumber` IS NOT NULL;

-- deleting the columns  addressline1 and addressline2 
ALTER TABLE `customers`
DROP COLUMN `addressLine1`, DROP COLUMN `addressLine2`;

/* replacing nulls with unknown in column state */
update customers
set state = "unknown"
where state is null;



/* replacing nulls with unknown in column postalcode */
update customers
set postalcode ="unknown"
where postalcode is null;


alter table orders
drop column comments;



update orders 
set shippeddate = 'YYYY-MM-DD'
where shippeddate is null;


ALTER TABLE `offices` ADD COLUMN `fullAddress` VARCHAR(255);



UPDATE `offices`
SET `fullAddress` = 
    CASE 
        WHEN `addressLine2` IS NULL THEN `addressLine1`
        ELSE CONCAT(`addressLine1`, ', ', `addressLine2`)
    END
WHERE `officecode` IS NOT NULL;
 
 
 
 ALTER TABLE `offices`
DROP COLUMN `addressLine1`, DROP COLUMN `addressLine2`;   



update offices
set state = "unknown"
where state is null