clc; clear; clf;
opts = spreadsheetImportOptions("NumVariables", 2);
opts.Sheet = "HNX Historical Data";
opts.DataRange = "A2:B142";
opts.VariableNames = ["Date", "Price"];
opts.VariableTypes = ["datetime", "double"];
HNXHistoricalData = readtable("/MATLAB Drive/HNX Historical Data.xlsx", opts, "UseExcel", false);
Date = HNXHistoricalData.Date;
Price = HNXHistoricalData.Price;
clear HNXHistoricalData opts

opts = spreadsheetImportOptions("NumVariables", 2);
opts.Sheet = "HNX_3_months_actual";
opts.DataRange = "A2:B64";
opts.VariableNames = ["Date1", "Price1"];
opts.VariableTypes = ["datetime", "double"];
HNX_3_months_actual = readtable("/MATLAB Drive/HNX_3_months_actual.xlsx", opts, "UseExcel", false);
actualPrice = HNX_3_months_actual.Price1;
clear HNX_3_months_actual opts


excelDate = convertTo(Date, 'excel');
t = excelDate(141)+1:excelDate(141)+70;

coefficient = polyfit(excelDate, Price, 1);
predicted_price = polyval(coefficient, t);
[n, n_] = size(predicted_price);

for i = 1:n_
    disp(i);
    disp(predicted_price(i));
end
plot(predicted_price);
subtitle('Stock price prediction using linear regression');
xlabel('Date');
ylabel('Price');
hold on
plot(actualPrice);
legend('Predicted price', 'Actual price');