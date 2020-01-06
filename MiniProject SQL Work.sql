USE GWSHealth

DROP TABLE dbo.CleanData
/*This allows for code to be run repeatedly and therefore makes it robust for when new data is added to the datatset or when exisiting data is altere or deleted.
Multiple DROP TABLE commands within the code have the same purpose. 
*/

--SELECT * FROM APC
--Commented out so code can be run without selecting the unclean data set, but useful in order to view the set for column headings. 

--DimEpitype Reference Table
/* This uses a CASE function to create a reference table that only contains foreign keys for values that exist within the dataset. 
It is robust and adaptable as it will allow for new epitpyes to be stored in the reference table when they are cited.
This format is repeated throughout the code. */

IF OBJECT_ID('dbo.DimEpitype') IS NOT NULL
BEGIN
	DROP TABLE dbo.DimEpitype
END
/*This function tests for the existence of the table 'DimEpitype', and then drops the table if it exists. 
This function is used each time I create a reference table, as it allows the code to be ran repeatedly and new tables to be created. */

SELECT DISTINCT
	epitype as ID,
	CASE
		WHEN epitype = '1' THEN 'General episode (anything that is not covered by the other codes)'
		WHEN epitype = '2' THEN 'Delivery episode'
		WHEN epitype = '3' THEN 'Birth episode'
		WHEN epitype = '4' THEN 'Formally detained under the provisions of mental health legislation or long-term (over one year) psychiatric patients'
		WHEN epitype = '5' THEN 'Other delivery event'
		WHEN epitype = '6' THEN 'Other birth event'
	END AS [DESCRIPTION]
INTO dbo.DimEpitype
FROM dbo.APC
--Using the NHS Data Dictionary for the proper terms and code references.

--SELECT * FROM DimEpitype
--This is commented out to avoid excessive querying but it was used to check the reference table was created appopriately. 

--DimSex Reference Table 
--The same format used above can be seen here, and throughout the code. 

IF OBJECT_ID('dbo.DimSex') IS NOT NULL
BEGIN
	DROP TABLE dbo.DimSex
END

SELECT DISTINCT
	Sex as ID,
	CASE
		WHEN sex = '1' THEN 'Male'
		WHEN sex = '2' THEN 'Female'
		WHEN sex = '9' THEN 'Not specified'
		WHEN sex = '0' THEN 'Not known'
	END AS [DESCRIPTION]
INTO dbo.DimSex
FROM dbo.APC
--SELECT * FROM DimSex

--EpiStat Reference Table

IF OBJECT_ID('dbo.DimEpistat') IS NOT NULL
BEGIN
	DROP TABLE dbo.DimEpistat
END

SELECT DISTINCT 
	epistat as ID,
	CASE 
		WHEN epistat = '1' THEN 'Unfinished'
		WHEN epistat = '3' THEN 'Finished'
		WHEN epistat = '9' THEN 'Derived unfinished (not present on processed data)'
	END AS [Description]
INTO dbo.DimEpistat
FROM dbo.APC

--SELECT * FROM DimEpistat

--AdminCat Reference Table

IF OBJECT_ID('dbo.DimAdmincat') IS NOT NULL
BEGIN
	DROP TABLE dbo.DimAdmincat
END
SELECT DISTINCT 
	admincat as ID,
	CASE 
		WHEN admincat = '1' THEN 'NHS patient including overseas visitors'
		WHEN admincat = '2' THEN 'Private patient'
		WHEN admincat = '3' THEN 'Amenity patient'
		WHEN admincat = '4' THEN 'A category II patient'
		WHEN admincat = '98' THEN 'Not applicable'
		WHEN admincat = '99' THEN 'Not Known'
	END AS [Description]
INTO dbo.DimAdmincat
FROM dbo.APC

--SELECT * FROM DimAdmincat

--AdminCatSt Reference Table

IF OBJECT_ID('dbo.DimAdmincatst') IS NOT NULL
BEGIN
     DROP TABLE dbo.DimAdmincatst
END
SELECT DISTINCT 
	admincatst as ID,
	CASE 
		WHEN admincatst	= '1' THEN 'NHS patient including overseas visitors'
		WHEN admincatst	= '2' THEN 'Private patient'
		WHEN admincatst	= '3' THEN 'Amenity patient'
		WHEN admincatst	= '4' THEN 'A category II patient'
		WHEN admincatst	= '98' THEN 'Not applicable'
		WHEN admincatst = '99' THEN 'Not Known'
	END AS [Description]
INTO dbo.DimAdmincatst
FROM dbo.APC

--SELECT * FROM DimAdmincatst

--Category Reference Table

IF OBJECT_ID('dbo.DimCategory') IS NOT NULL
BEGIN
DROP TABLE dbo.DimCategory
END
SELECT DISTINCT
	category as ID,
	CASE
		WHEN category = '10' THEN 'NHS patient: not formally detained'
		WHEN category = '11' THEN 'NHS patient: formally detained under Part II of the Mental Health Act 1983'
		WHEN category = '12' THEN 'NHS patient: formally detained under Part III of the Mental Health Act 1983 or under other Acts'
		WHEN category = '13' THEN 'NHS patient: formally detained under part X, Mental Health Act 1983'  
		WHEN category = '20' THEN 'Private patient: not formally detained'
		WHEN category = '21' THEN 'Private patient: formally detained under Part II of the Mental Health Act 1983'
		WHEN category = '22' THEN 'Private patient: formally detained under Part III of the Mental Health Act 1983 or under other Acts'
		WHEN category = '23' THEN 'Private patient: formally detained under part X, Mental health Act 1983'
		WHEN category = '30' THEN 'Amenity patient: not formally detained'
		WHEN category = '31' THEN 'Amenity patient: formally detained under Part II of the Mental Health Act 1983'
		WHEN category = '32' THEN 'Amenity patient: formally detained under Part III of the Mental Health Act 1983 or under other Acts'
		WHEN category = '33' THEN 'Amenity patient: formally detained under part X, Mental health Act 1983'
	END AS DESCRIPTION
INTO dbo.DimCategory
FROM dbo.APC

--SELECT * FROM DimCategory

--ETHNOS REFERENCE TABLE

IF OBJECT_ID('dbo.DimEthnos') IS NOT NULL
BEGIN
	DROP TABLE dbo.DimEthnos
END
SELECT DISTINCT
	ethnos as ID,
	CASE
		WHEN ethnos = 'A' THEN 'British (White)'
		WHEN ethnos = 'B' THEN 'Irish (White)'
		WHEN ethnos = 'C' THEN 'Another other White background'
		WHEN ethnos = 'D' THEN 'White and Black Caribbean (Mixed)'
		WHEN ethnos = 'E' THEN 'White and Black African (Mixed)'
		WHEN ethnos = 'F' THEN 'White and Asian (Mixed)'
		WHEN ethnos = 'G' THEN 'Any other Mixed background'
		WHEN ethnos = 'H' THEN 'Indian (Asian or Asian British)'
		WHEN ethnos = 'J' THEN 'Pakistani (Asian or Asian British)'
		WHEN ethnos = 'K' THEN 'Bangladeshi (Asian or Asian British)'
		WHEN ethnos = 'L' THEN 'Any other Asian background'
		WHEN ethnos = 'M' THEN 'Caribbean (Black or British)'
		WHEN ethnos = 'N' THEN 'African (Black or British)'
		WHEN ethnos = 'P' THEN 'Any other black background'
		WHEN ethnos = 'R' THEN 'Chinese (other ethnic group)'
		WHEN ethnos = 'S' THEN 'Any other ethnic group'
		WHEN ethnos = 'Z' THEN 'Not stated'
		WHEN ethnos = 'X' THEN 'Not known'
		WHEN ethnos = '99' THEN 'Not known'
		WHEN ethnos = '0' THEN 'White'
		WHEN ethnos = '1' THEN 'Black'
		WHEN ethnos = '2' THEN 'Black - African'
		WHEN ethnos = '3' THEN 'Black - Other'
		WHEN ethnos = '4' THEN 'Indian'
		WHEN ethnos = '5' THEN 'Pakistani'
		WHEN ethnos = '6' THEN 'Bangladeshi'
		WHEN ethnos = '7' THEN 'Chinese'
		WHEN ethnos = '8' THEN 'Any other ethnic group'
		WHEN ethnos = '9' THEN 'Not given'
	END AS DESCRIPTION
INTO dbo.DimEthnos
FROM dbo.APC

--SELECT * FROM DimEthnos

--LeglCat Reference Table

IF OBJECT_ID('dbo.DimLeglCat') IS NOT NULL
BEGIN
     DROP TABLE dbo.DimLeglCat
END
SELECT DISTINCT
	leglcat as ID,
	CASE
		WHEN leglcat = '01' THEN 'Informal'
		WHEN leglcat = '02' THEN 'Formally detained under the Mental Health Act, Section 2'
		WHEN leglcat = '03' THEN 'Formally detained under the Mental Health Act, Section 3'
		WHEN leglcat = '04' THEN 'Formally detained under the Mental Health Act, Section 4'
		WHEN leglcat = '05' THEN 'Formally detained under the Mental Health Act, Section 5(2)'
		WHEN leglcat = '06' THEN 'Formally detained under the Mental Health Act, Section 5(4)'
		WHEN leglcat = '07' THEN 'Formally detained under the Mental Health Act, Section 35'
		WHEN leglcat = '08' THEN 'Formally detained under the Mental Health Act, Section 36'
		WHEN leglcat = '09' THEN 'Formally detained under the Mental Health Act, Section 37 with Section 41 restrictions'
		WHEN leglcat = '10' THEN 'Formally detained under the Mental Health Act, Section 37 excluding Section 37(4)'
		WHEN leglcat = '11' THEN 'Formally detained under the Mental Health Act, Section 37(4)'
		WHEN leglcat = '12' THEN 'Formally detained under the Mental Health Act, Section 38'
		WHEN leglcat = '13' THEN 'Formally detained under the Mental Health Act, Section 44'
		WHEN leglcat = '14' THEN 'Formally detained under the Mental Health Act, Section 46'
		WHEN leglcat = '15' THEN 'Formally detained under the Mental Health Act, Section 47 with Section 49 restrictions'
		WHEN leglcat = '16' THEN 'Formally detained under the Mental Health Act, Section 47'
		WHEN leglcat = '17' THEN 'Formally detained under the Mental Health Act, Section 48 with Section 49 restrictions'
		WHEN leglcat = '18' THEN 'Formally detained under the Mental Health Act, Section 48'
		WHEN leglcat = '19' THEN 'Formally detained under the Mental Health Act, Section 135'
		WHEN leglcat = '20' THEN 'Formally detained under the Mental Health Act, Section 136'
		WHEN leglcat = '21' THEN 'Formally detained under the previous legislation (fifth schedule)'
		WHEN leglcat = '22' THEN 'Formally detained under Criminal Procedure (Insanity) Act 1964 as amended by the Criminal Procedures (Insanity and Unfitness to Plead) Act 1991'
		WHEN leglcat = '23' THEN 'Formally detained under other Acts'
		WHEN leglcat = '24' THEN 'Supervised discharge under the Mental Health (Patients in the Community) Act 1995'
		WHEN leglcat = '25' THEN 'Formally detained under the Mental Health Act, Section 45A'
		WHEN leglcat = '26' THEN 'Not applicable'
		WHEN leglcat = '27' THEN 'Not known'
		WHEN leglcat = '00' THEN 'Not known'
	END AS DESCRIPTION
INTO dbo.DimLeglCat
FROM dbo.APC

--SELECT * FROM DimLeglCat

--AdmiMeth Reference Table

IF OBJECT_ID('dbo.DimAdmiMeth') IS NOT NULL
BEGIN
DROP TABLE dbo.DimAdmiMeth
END
SELECT DISTINCT 
	admimeth as ID,
	CASE 
		WHEN admimeth = '11' THEN 'Waiting list: Elective Admission'
		WHEN admimeth = '12' THEN 'Booked: Elective Admission'
		WHEN admimeth = '13' THEN 'Planned: Elective Admission'
		WHEN admimeth = '21' THEN 'Accident and emergency or dental casualty department of the Health Care Provider: Emergency Admission'
		WHEN admimeth = '22' THEN 'General Practitioner: Emergency Admission'
		WHEN admimeth = '23' THEN 'Bed bureau: Emergency Admission'
		WHEN admimeth = '24' THEN 'Consultant Clinic: Emergency Admission'
		WHEN admimeth = '25' THEN 'Admission via Mental Health Crisis Resolution Team: Emergency Admission'
		WHEN admimeth = '2A' THEN 'Accident and Emergency Department of another provider where the patient had not been admitted: Emergency Admission'
		WHEN admimeth = '2B' THEN 'Transfer of an admitted patient from another Hospital Provider in an emergency: Emergency Admission' 
		WHEN admimeth = '28' THEN ' Other means: Emergency Admission'
		WHEN admimeth = '31' THEN 'Admitted ante-partum: Maternity Admission'
		WHEN admimeth = '32' THEN 'Admitted post-partum: Maternity Admission'
		WHEN admimeth = '82' THEN 'The birth of a baby in this Health Care Provider: Other Admission'
		WHEN admimeth = '83' THEN 'Baby born outside the Health Care Provider except when born at home as intended: Other Admission'
		WHEN admimeth = '81' THEN 'Transfer of any admitted patient from other Hospital Provider other than in an emergency: Other Admission'
		WHEN admimeth = '84' THEN 'Admission by Admissions Panel of a High Security Psychiatric Hospital: Other Admission'
		WHEN admimeth = '89' THEN 'HSPH Admissions Waiting List of a High Security Psychiatric Hospital: Other Admission'
		WHEN admimeth = '98' THEN 'Not applicable (available from 1996/97): Other Admission'
		WHEN admimeth = '99' THEN 'Not known: a validation error'

	END as [Description]
INTO dbo.DimAdmimeth
FROM dbo.APC


--SELECT * FROM DimAdmiMeth

--AdminSorc Reference Table

IF OBJECT_ID('dbo.DimAdmisorc') IS NOT NULL
BEGIN
DROP TABLE dbo.DimAdmisorc
END
SELECT DISTINCT
	AdmiSorc as ID,
	CASE
		WHEN Admisorc = '19' THEN  'The usual place of residence, unless listed below, for example, a private dwelling whether owner occupied or owned by Local Authority, housing association or other landlord. This includes wardened accommodation but not residential accommodation where health care is provided. It also includes PATIENTS with no fixed abode.'
		WHEN Admisorc = '29' THEN  'Temporary place of residence when usually resident elsewhere, for example, hotels and residential educational establishments'
		WHEN Admisorc = '30' THEN  'Repatriation from high security psychiatric hospital (1999-00 to 2006-07)'
		WHEN Admisorc = '37' THEN  'Penal establishment: court (1999-00 to 2006-07)'
		WHEN Admisorc = '38' THEN  'Penal establishment: police station (1999-00 to 2006-07)'
		WHEN Admisorc = '39' THEN  'Penal establishment, Court or Police Station / Police Custody Suite'
		WHEN Admisorc = '48' THEN  'High security psychiatric hospital, Scotland (1999-00 to 2006-07)'
		WHEN Admisorc = '49' THEN  'NHS other hospital provider: high security psychiatric accommodation in an NHS hoSpital provider (NHS trust or NHS Foundation Trust)'
		WHEN Admisorc = '50' THEN  'NHS other hospital provider: medium secure unit (1999-00 to 2006-07)'
		WHEN Admisorc = '51' THEN  'NHS other hospital provider: ward for general patients or the younger physically disabled or A&E department'
		WHEN Admisorc = '52' THEN  'NHS other hospital provider: ward for maternity patients or neonates'
		WHEN Admisorc = '53' THEN  'NHS other hospital provider: ward for patients who are mentally ill or have learning disabilities'
		WHEN Admisorc = '54' THEN  'NHS run Care Home'
		WHEN Admisorc = '65' THEN  'Local authority residential accommodation i.e. where care is provided'
		WHEN Admisorc = '66' THEN  'Local authority foster care, but not in residential accommodation i.e. where care is provided'
		WHEN Admisorc = '69' THEN  'Local authority home or care (1989-90 to 1995-96)'
		WHEN Admisorc = '79' THEN  'Babies born in or on the way to hospital'
		WHEN Admisorc = '85' THEN  'Non-NHS (other than Local Authority) run care home'
		WHEN Admisorc = '86' THEN  'Non-NHS (other than Local Authority) run nursing home'
		WHEN Admisorc = '87' THEN  'Non-NHS run hospital'
		WHEN Admisorc = '88' THEN  'non-NHS (other than Local Authority) run hospice'
		WHEN Admisorc = '89' THEN  'Non-NHS institution (1989-90 to 1995-96)'
		WHEN Admisorc = '98' THEN  'Not applicable'
		WHEN Admisorc = '99' THEN  'Not known'
	END AS DESCRIPTION
INTO dbo.DimAdmisorc
FROM dbo.APC

--ClassPat Reference Table

IF OBJECT_ID('dbo.DimClasspat') IS NOT NULL
BEGIN
DROP TABLE dbo.DimClasspat
END
SELECT DISTINCT 
	classpat as ID,
	CASE 
		WHEN classpat = '1' THEN 'Ordinary admission'
		WHEN classpat = '2' THEN 'Day case admission' 
		WHEN classpat = '3' THEN 'Regular day attender'
		WHEN classpat = '4' THEN 'Regular night attender'
		WHEN classpat = '5' THEN 'Mothers and babies usin only delivery facilities'
		WHEN classpat = '8' THEN 'Not applicable (other maternity event)'
		WHEN classpat = '9' THEN 'Not known'
	END as [Description]
INTO dbo.DimClasspat
FROM dbo.APC
--SELECT * FROM DimClasspat

--DimSpellBgin Reference Table

IF OBJECT_ID('dbo.DimSpellBgin') IS NOT NULL
BEGIN
	DROP TABLE dbo.DimSpellBgin
END
SELECT DISTINCT 
	spellbgin as ID,
	CASE 
		when spellbgin = '0' then 'Not the first episode'
		when spellbgin = '1' then 'First episode of spelll that started in previous year' 
		when spellbgin = '2' then 'First episode of spell that started in current year'
		when spellbgin = 'NULL' then 'Not known'
	END as [Description]
INTO dbo.DimSpellBgin
FROM dbo.APC
--SELECT * FROM DimSpellBgin

/* After creating multiple reference tables, these tables can be joined to the dbo.APC unclean dataset to produce a readable dataset.
This will become the clean dataset, and will also test for NULLS and replace them. 
First through eyeballing the data after first completing the join, I determined where the Null values were.
I then updated the join code to replace the NULLS. */

--Join Tables

SELECT
	spell,
	episode,
	epistart,
	epiend,
	CASE WHEN dimepitype.[description] is null then 'Not Known'		--In most instances I chose to replace NULL values with 'Not Known', as this is consistent with the NHS Data Dictionary. 
		ELSE dimepitype.[description]
		END as epitype,
	dimsex.[description] as sex,
	CASE WHEN bedyear is null THEN datediff(dd, epistart, epiend)
		ELSE bedyear
		END as bedyear,
	epidur,
	dimepistat.description as epistat,
	dimSpellBgin.description as spellbgin,
	activage,
	admiage,
	dimadmincat.description as admincat,
	dimadmincatst.description as admincatst,
	dimCategory.description category,
	dob,
	CASE WHEN endage is null THEN 'Not Known'
		ELSE endage
		END as endage,
	CASE WHEN DimEthnos.[DESCRIPTION] is null THEN 'Not Known'
		ELSE DimEthnos.[DESCRIPTION]
		END as ethnos,
	hesid,
	dimLeglCat.description leglcat,
	lopatid,
	mydob,
	CASE WHEN newnhsno is null THEN 'Not Known'
		ELSE newnhsno 
		END as newnhsno,
	newnhsno_check,
	startage,
	admistart,
	dimAdmiMeth.description admimeth,
	dimAdmisorc.description admisorc,
	CASE WHEN elecdate is null THEN '1800-01-01' 
		ELSE elecdate										
		END as elecdate,
	--Here I replaced the NULL values with this data as it is consistent with the NHS Data Dictonary. The NHS standard is to use '1800-01-01' when a NULL date is submitted.
	--The NHS also uses '1801-01-01' for invalid dates, so this is something to be aware of when using the data in its downstream componenent.
	elecdur,
	elecdur_calc,
	classpat,
	diag_01
into dbo.CleanData
from dbo.APC as A
--This command will join the APC table with the reference tables, whilst adding it to a new table 'CleanData'
--Left Join retains the same number of rows as the APC table (51,615), whilst an inner join loses approx 3000 rows
LEFT JOIN dimepitype on A.epitype = dimepitype.ID
LEFT JOIN dimsex on A.sex = dimsex.ID
LEFT JOIN dimepistat on A.epistat = dimepistat.ID
LEFT JOIN dimSpellBgin on A.spellbgin = dimSpellBgin.ID
LEFT JOIN dimadmincat on A.admincat = dimadmincat.ID
LEFT JOIN dimadmincatst on A.admincatst = dimadmincatst.ID
LEFT JOIN dimCategory on A.category = dimCategory.ID
LEFT JOIN DimEthnos on A.ethnos = DimEthnos.ID
LEFT JOIN dimLeglCat on A.leglcat = DimLeglCat.ID
LEFT JOIN dimAdmiMeth on A.admimeth = dimAdmiMeth.ID
LEFT JOIN dimadmisorc on A.admisorc = dimadmisorc.ID

SELECT * FROM CleanData

--This then displays the readable dataset.

--Commented out are functions used to double check for any missed NULLs after eyeballing the data.
/*SELECT * FROM CleanData WHERE epistart is null 
SELECT * FROM CleanData WHERE epiend is null 
SELECT * FROM CleanData WHERE epitype is null 
SELECT * FROM CleanData WHERE sex is null 
SELECT * FROM CleanData WHERE bedyear is null 
SELECT * FROM CleanData WHERE epidur is null 
SELECT * FROM CleanData WHERE epistat is null 
SELECT * FROM CleanData WHERE spellbgin is null 
SELECT * FROM CleanData WHERE activage is null 
SELECT * FROM CleanData WHERE admiage is null 
SELECT * FROM CleanData WHERE admincat is null 
SELECT * FROM CleanData WHERE admincatst is null 
SELECT * FROM CleanData WHERE category is null 
SELECT * FROM CleanData WHERE dob is null 
SELECT * FROM CleanData WHERE endage is null 
SELECT * FROM CleanData WHERE ethnos is null 
SELECT * FROM CleanData WHERE hesid is null 
SELECT * FROM CleanData WHERE leglcat is null 
SELECT * FROM CleanData WHERE lopatid is null 
SELECT * FROM CleanData WHERE mydob is null 
SELECT * FROM CleanData WHERE newnhsno is null 
SELECT * FROM CleanData WHERE newnhsno_check is null 
SELECT * FROM CleanData WHERE startage is null 
SELECT * FROM CleanData WHERE admistart is null 
SELECT * FROM CleanData WHERE admimeth is null 
SELECT * FROM CleanData WHERE admisorc is null
SELECT * FROM CleanData WHERE elecdate is null 
SELECT * FROM CleanData WHERE elecdur is null 
SELECT * FROM CleanData WHERE elecdur_calc is null 
SELECT * FROM CleanData WHERE classpat is null 
SELECT * FROM CleanData WHERE diag_01 is null*/

