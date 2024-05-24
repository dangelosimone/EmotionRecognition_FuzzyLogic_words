% Definisci la lista di parole in inglese da tradurre
[word1, word2, word3, score1, score2, posscore, negscore]=readTrainData();
parole_inglese = word2;

% Inizializza la lista vuota per le traduzioni
parole_italiano = cell(size(parole_inglese));

h = waitbar(0,'SentiNet','Name','Traslation...',...
            'CreateCancelBtn',...
            'setappdata(gcbf,''canceling'',1)');
setappdata(h,'canceling',0)
% Ciclo su ogni parola in inglese e ottieni la traduzione
for i = 1:numel(parole_inglese)
    % Esegui la richiesta HTTP per tradurre la parola
    url = sprintf('https://translate.googleapis.com/translate_a/single?client=gtx&sl=en&tl=it&dt=t&q=%s', urlencode(parole_inglese{i}));
    response = webread(url);
    
    % Estrai la traduzione dalla risposta
    traduzione = response{1}{1}{1};
    
    % Aggiungi la traduzione alla lista
    parole_italiano{i} = traduzione;
    waitbar(i / numel(parole_inglese), h);
end

% Visualizza le parole tradotte
disp(parole_italiano);
disp(score1(1));


% Definisci l'array da scrivere nella prima colonna del CSV

% Apri il file CSV in modalità di scrittura ('w')
fileID = fopen('Data/Train/labmt-preprocITA.csv', 'w');

% Controlla se l'apertura del file è avvenuta correttamente
if fileID == -1
    error('Impossibile aprire il file per la scrittura');
end

% Itera sull'array e scrivi ciascun elemento nella prima colonna del file
% CSV

% Definisci la stringa da scrivere nella prima colonna

% Scrivi la stringa nella prima colonna del file CSV
for i = 1:numel(parole_italiano)
    fprintf(fileID, '%s,%d\n', parole_italiano{i},score2(i));
end

% Chiudi il file
fclose(fileID);

