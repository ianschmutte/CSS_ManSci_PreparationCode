/********************
	RAIS_harmonize_2013.sas
	Ian M. Schmutte

	2019-March-20

	DESCRIPTION: Enforce consistent variable formatting across years
*********************/
   
    /*header information*/
	%INCLUDE "./SASharmonizeHeader.sas";

%let year = 2013;

proc contents data=INTERWRK.rais&year._raw;
run;

%macro zeropad(var,leng);
	ell = length(trim(left(&var.)));
	if ell < &leng. then &var. = repeat('0',&leng.-ell-1)||&var.;
%mend;

data IRAIS.irais&year.(drop = SEX);
  set INTERWRK.rais&year._raw;
  length GENDER $1.;
  GENDER = "F";
  if SEX = "01" then GENDER = "M";
  %zeropad(PIS,11);
  %zeropad(PLANT_ID,14);
  %zeropad(CPF,11);
  %zeropad(CTPS,8);
run;