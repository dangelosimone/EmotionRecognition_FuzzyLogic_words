% Read in all data from all the preprocessed datasets.
function [word1, word2, word3, score1, score2, posscore, negscore] = readTrainData_Ita()
    [word1, score1] = importSingleVariable('Data/Train/AFINN-111-preprocessedITA.csv', 2, 2300);
    [word2, score2] = importSingleVariable('Data/Train/labmt-preprocITA_bk.csv', 2, 10200); %10223
    [word3, posscore, negscore] = importDoubleVariable('Data/Train/SentiNet-preprocessedITA.csv', 2, 116649); %116649
    
end
