clc; clear; clf;
format compact

opts = spreadsheetImportOptions("NumVariables", 2);
opts.Sheet = "EVS Historical Data";
opts.DataRange = "A2:B141";
opts.VariableNames = ["Date", "Price"];
opts.VariableTypes = ["datetime", "double"];
EVSHistoricalData = readtable("/MATLAB Drive/EVS Historical Data.xlsx", opts, "UseExcel", false);
EVSPrice = EVSHistoricalData.Price;
clear EVSHistoricalData opts

opts = spreadsheetImportOptions("NumVariables", 2);
opts.Sheet = "EVS Historical Data";
opts.DataRange = "A142:B205";
opts.VariableNames = ["Date", "Price"];
opts.VariableTypes = ["datetime", "double"];
EVSHistoricalData = readtable("/MATLAB Drive/EVS Historical Data.xlsx", opts, "UseExcel", false);
EVSPrice3Months = EVSHistoricalData.Price;
clear EVSHistoricalData opts

opts = spreadsheetImportOptions("NumVariables", 2);
opts.Sheet = "BNA Historical Data";
opts.DataRange = "A2:B141";
opts.VariableNames = ["Date", "Price"];
opts.VariableTypes = ["datetime", "double"];
BNAHistoricalData = readtable("/MATLAB Drive/BNA Historical Data.xlsx", opts, "UseExcel", false);
usedBNAPrice = BNAHistoricalData.Price;
clear BNAHistoricalData opts

opts = spreadsheetImportOptions("NumVariables", 2);
opts.Sheet = "BNA Historical Data";
opts.DataRange = "A142:B205";
opts.VariableNames = ["Date", "Price"];
opts.VariableTypes = ["datetime", "double"];
BNAHistoricalData = readtable("/MATLAB Drive/BNA Historical Data.xlsx", opts, "UseExcel", false);
actualFutureBNAPrice = BNAHistoricalData.Price;
clear BNAHistoricalData opts

first7Months = 1:140;
first7Months = first7Months';
next3Months = 141:204;
next3Months = next3Months';


predictor = [EVSPrice, first7Months];
%predictor = first7Months;
response = usedBNAPrice;
mdl = fitlm(predictor, response);
new = [EVSPrice3Months, next3Months];
%new = next3Months;

predictedPrice = predict(mdl, new);

plot(predictedPrice);
title('BNA price predicted using EVS data');
%title('BNA price prediction');
xlabel('Date');
ylabel('Price');
hold on
plot(actualFutureBNAPrice);
legend('Predicted BNA price', 'Actual BNA price');