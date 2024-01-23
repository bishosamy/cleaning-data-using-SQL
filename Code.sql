select * from Nashville_Housingnew

-- The new column is what we want the SaleDate to look like.

UPDATE Nashville_Housingnew

SET SaleDate = CONVERT (Date, SaleDate)

-- Use UPDATE to change SaleDate to Date Format.

-- Add a new column with the standardized date. Use ALTER TABLE, then UPDATE.

ALTER TABLE Nashville_Housingnew

Add SaleDateConverted Date;

UPDATE Nashville_Housingnew

SET SaleDateConverted = CONVERT(Date, SaleDate)

-- Check to see if new column SaleDateConverted is correct.

SELECT SaleDateConverted, CONVERT(Date, SaleDate)

from Nashville_Housingnew

select PropertyAddress 
from Nashville_Housingnew
where PropertyAddress is null

select * 
from Nashville_Housingnew
order by ParcelID


select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, isnull(a.PropertyAddress,b.PropertyAddress)
from Nashville_Housingnew a
join Nashville_Housingnew b
on a.ParcelID= b.ParcelID
and a.UniqueID <> b.UniqueID
where a.PropertyAddress is null

update a
set PropertyAddress = isnull(a.PropertyAddress,b.PropertyAddress)
from Nashville_Housingnew a
join Nashville_Housingnew b
on a.ParcelID= b.ParcelID
and a.UniqueID <> b.UniqueID
where a.PropertyAddress is null

select PropertyAddress,subSTRING(PropertyAddress,1,ChARINDEX(',',PropertyAddress)-1) as address,
       SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,len(PropertyAddress)) as City 
from Nashville_Housingnew

Alter table Nashville_Housingnew
Add SplitProportyAddress NvarChar(255);

update Nashville_Housingnew
Set SplitProportyAddress= subSTRING(PropertyAddress,1,ChARINDEX(',',PropertyAddress)-1)

Alter table Nashville_Housingnew
Add SplitProportyCity NvarChar(255);

update Nashville_Housingnew
set SplitProportyCity = subString(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,len(PropertyAddress)) 


select PARSENAME(replace(OwnerAddress,',','.'),3),
       ParseName(replace(OwnerAddress,',','.'),2),
	   ParseName(replace(OwnerAddress,',','.'),1)
from Nashville_Housingnew

Alter table Nashville_Housingnew
Add SplitOwnerAddress NvarChar(255)

Update Nashville_Housingnew
Set SplitOwnerAddress= PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)

Alter table Nashville_Housingnew
Add SplitOwnerCity NvarChar(255)

Update Nashville_Housingnew
Set SplitOwnerCity= PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)

Alter table Nashville_Housingnew
Add SplitOwnerState NvarChar(255)

Update Nashville_Housingnew
Set SplitOwnerState= PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)


select DISTINCT(SoldAsVacant),count(SoldAsVacant)
from Nashville_Housingnew
group by SoldAsVacant
order by 2

select SoldAsVacant, 
       case
	   when SoldAsVacant = 'Y' THEN 'Yes'
       when SoldAsVacant = 'N' THEN 'NO'
	   else SoldAsVacant
	   end
from Nashville_Housingnew

UPDATE Nashville_Housingnew
set SoldAsVacant= case
	   when SoldAsVacant = 'Y' THEN 'Yes'
       when SoldAsVacant = 'N' THEN 'NO'
	   else SoldAsVacant
	   end

/* Check for duplicates. */
with RowNumCTE AS (select *, ROW_NUMBER() over(partition by ParcelID,PropertyAddress, SaleDate, SalePrice, LegalReference order by UniqueID) as row_num   
from Nashville_Housingnew)

select *
from RowNumCTE
where row_num >1

with RowNumCTE AS (select *, ROW_NUMBER() over(partition by ParcelID,PropertyAddress, SaleDate, SalePrice, LegalReference order by UniqueID) as row_num   
from Nashville_Housingnew)

delete
from RowNumCTE
where row_num >1

SELECT *

FROM Nashville_Housingnew

ALTER TABLE Nashville_Housingnew

DROP COLUMN OwnerAddress, PropertyAddress

