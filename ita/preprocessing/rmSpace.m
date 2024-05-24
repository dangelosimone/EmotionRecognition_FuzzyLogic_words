[word1, word2, word3, score1, score2, posscore, negscore]=readTrainData();
data = readcell('../Data/Train/labmt-preprocITA.csv');
n_word_Senti_Net = 10200;
disp(data(:,1))

word_data = cell(size(data));

word_data_SentiNet = data(:,1);


for i=1:n_word_Senti_Net
    str = word_data_SentiNet{i};
    str = strrep(str, ' ', '_');
end


% Apri il file CSV in modalità di scrittura ('w')
fileID = fopen('../Data/Train/labmt-preprocITA_bk.csv', 'w');

% Controlla se l'apertura del file è avvenuta correttamente
if fileID == -1
    error('Impossibile aprire il file per la scrittura');
end

% Itera sull'array e scrivi ciascun elemento nella prima colonna del file
% CSV

% Definisci la stringa da scrivere nella prima colonna

% Scrivi la stringa nella prima colonna del file CSV
for i = 1:n_word_Senti_Net
    str = word_data_SentiNet{i};
    str = strrep(str, ' ', '_');
    disp(i)
    fprintf(fileID, '%s,%d\n', str,score2(i));
end

% Chiudi il file
fclose(fileID);



