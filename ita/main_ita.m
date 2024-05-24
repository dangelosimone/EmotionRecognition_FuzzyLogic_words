% Main program to calculate crisp output of a sentence's sentiment
% with the help of a FLS

% Gather all the data
[word1, word2, word3, score1, score2, posscore, negscore] = readTrainData_Ita();
input_sentence = input('Inserisci una sequenza di caratteri: ', 's');
test_sentences = cellstr(input_sentence);

% Read in the FLS
fls = readfis('FuzzySentiment.fis');
outcome_data = [];

% Set numbers for the waitbar
full_length = size(test_sentences,1);
full_counter = 0;

for sentence = test_sentences'
    % Check for Cancel button press
    
    % Break every sentence into seperate words and remove punctuation etc
    [sentence_words] = sentenceToWords(sentence{1});

    % Set initial values
    sentence_score_AFINN = 0;
    count_AFINN = 0;
    sentence_score_LABMT = 0;
    count_LABMT = 0;
    sentence_score_SENTINET_POS = 0;
    count_SENTINET_POS = 0;
    sentence_score_SENTINET_NEG = 0;
    count_SENTINET_NEG = 0;

    % For every word in the sentence, get the sentiment based on three
    % different datasets
    array = {};
    for i=1:numel(sentence_words)
        word = sentence_words{i};
        if ismember(word,array)
            continue;
        end
        array = [array,word];
       if ismember(word, word1)
           index = strmatch(word, word1, 'exact');
           word_score_1 = score1(index);
           word_score_1 = sum(word_score_1)/numel(word_score_1);
           %fprintf('Dataset: AFINN -> %s: %.2f\n',word,word_score_1);
           fprintf('Dataset: AFINN -> %s\n',word);
           sentence_score_AFINN = sentence_score_AFINN + word_score_1;
           count_AFINN = count_AFINN + 1;
       
       elseif ismember(word, word2)
           index = strmatch(word, word2, 'exact');
           word_score_2 = score2(index);
           word_score_2 = sum(word_score_2)/numel(word_score_2);
           %fprintf('Dataset: LABMT -> %s: %.2f\n',word,word_score_2);
           %fprintf('Dataset: LABMT -> %s\n',word);
           sentence_score_LABMT = sentence_score_LABMT + word_score_2;
           count_LABMT = count_LABMT + 1;
       
       elseif ismember(word, word3)
           index = strmatch(word, word3, 'exact');
           word_pos = posscore(index);
           % At this moment some words occur multiple times in the SentiNet
           % dataset, here we get all the values for a single word an take the
           % average of those values
           
           if size(word_pos, 1) > 1
               word_pos = mean(word_pos);
           end
           word_neg = negscore(index);
           if size(word_neg, 1) > 1
               word_neg = mean(word_neg);
           end
           
           word_pos = sum(word_pos)/numel(word_pos);
           word_neg = sum(word_neg)/numel(word_neg);

           % Data Norm sentiWord
           word_pos = word_pos/(5);
           word_neg = word_neg/(5);

           %fprintf('Dataset: SENTINET -> %s: pos:%.2f - neg:%.2f\n',word,word_pos,word_neg);
           %fprintf('Dataset: SENTINET -> %s\n',word);
           sentence_score_SENTINET_POS = sentence_score_SENTINET_POS + word_pos;
           count_SENTINET_POS = count_SENTINET_POS + 1;
           sentence_score_SENTINET_NEG = sentence_score_SENTINET_NEG - word_neg;
           count_SENTINET_NEG = count_SENTINET_NEG + 1;
       end  
    end
    % Get an average sentiment for the sentence based on the amount of
    % sentimental words in the sentence
    
    sentence_score_AFINN = sentence_score_AFINN / count_AFINN;
    sentence_score_LABMT = sentence_score_LABMT / count_LABMT;
    sentence_score_SENTINET_POS = sentence_score_SENTINET_POS / count_SENTINET_POS;
    sentence_score_SENTINET_NEG = abs(sentence_score_SENTINET_NEG / count_SENTINET_NEG);
    

    % If there were no sentimental words, set values to neutral
    if isnan(sentence_score_AFINN)
        sentence_score_AFINN = 0;
    end
    if isnan(sentence_score_LABMT)
        sentence_score_LABMT = 5;
    end
    if isnan(sentence_score_SENTINET_POS)
        sentence_score_SENTINET_POS = 0.5;
    end
    if isnan(sentence_score_SENTINET_NEG)
        sentence_score_SENTINET_NEG = 0.5;
    end
    
    % Get an average sentiment for the sentence based on the amount of
    % sentimental words in the sentence
    
    % Input Sentence Store (more operations)
    input_sentence_score_AFINN = sum(sentence_score_AFINN)/numel(sentence_score_AFINN);
    input_sentence_score_SENTINET_POS = sum(sentence_score_SENTINET_POS)/numel(sentence_score_SENTINET_POS);
    input_sentence_score_SENTINET_NEG = sum(sentence_score_SENTINET_NEG)/numel(sentence_score_SENTINET_NEG);
    input_sentence_score_LABMT = sum(sentence_score_LABMT)/numel(sentence_score_LABMT);
    
    

    % Make the input for the FLS
    input_fls = [
        input_sentence_score_AFINN,
        input_sentence_score_SENTINET_POS,
        input_sentence_score_SENTINET_NEG,
        input_sentence_score_LABMT];
    % disp(input_fls)
    
    
    % Put it in the FLS and generate crisp output
    % output_score = evalfis(input_fls, fls);
    output_score = evalfis(fls, input_fls);
    full_counter = full_counter + 1;
    disp("  ")
    disp(input_sentence)
    disp("  ")
    %disp("Emotion Value: ")
    %value_emotion = ((output_score/(2))*100)+50;
    value_emotion = ((output_score)+1)*50;
    %disp(value_emotion)


    % Calcola il resto per far sì che la somma sia 100
    rest = 100 - value_emotion;

    % Crea il vettore dei valori per il grafico a torta
    val = [value_emotion, rest];

    % Etichette delle sezioni
    label_fuzzy = ['Fuzzy Emotion Value: ', num2str(value_emotion)];
    labels = {label_fuzzy,''};
    
    % Definisci i colori per le varie partizioni
    colors = [0.5 0.5 1;  % colore per la prima partizione
              0.5 0.5 0.5]; % colore per la seconda partizione
    
    % Crea il grafico a torta
    figure; % Creazione di una nuova figura
    h = pie3(val, labels);
    colormap(colors);
    
    % Nascondo Etichette
    text_handles = findobj(h, 'Type', 'text');
    set(text_handles, 'Visible', 'off');
    
    % Aggiungi un titolo al grafico
    title('Fuzzy Emotion Analysis','FontSize', 18);
    
    % Aggiungi una legenda
    %legend(labels, 'Location', 'best','FontSize',14);
    %legend(labels, 'FontSize', 14, 'Location', 'southoutside', 'Orientation', 'horizontal');
    legend(labels, 'FontSize', 14, 'Location', 'southoutside', 'Orientation', 'horizontal', 'Position', [0.25, 0.25, 0.55, 0]);
    
    % Applica un'illuminazione migliore
    lightangle(45, 30);
    
    % Aggiungi un'interattività per esplorare il grafico
    dcm_obj = datacursormode(gcf);
    set(dcm_obj, 'UpdateFcn', @displayInfo);

    % if output is positive, set to 1 for comparisson with testdata 
    if output_score > 0
        outcome_data = [outcome_data; [1, output_score]];
    % else set to 0
    else 
        outcome_data = [outcome_data; [0, output_score]];
    end
end

%result = outcome_data(:,1) == test_score;
emotion = outcome_data(1,1);
if emotion == 1
    disp("Emotion Value: Positivo")
    disp("  ")
else
    disp("Emotion Value: Negativo")
    disp("  ")
end
disp("Il sentimento provato è Positivo poichè nell'input sono presenti: OTTIMA, BENE")
%disp('test_score');
%accuaracy = (sum(result) / size(result,1)) * 100;

%disp('Accuracy');
%disp(accuaracy);

