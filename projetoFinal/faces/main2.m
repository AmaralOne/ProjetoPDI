%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Arlindo Galvão - PDI2019 %%
%%        MAIN             %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all, close all
%% Iniciar o parâmetros

    qtd_classes = 100;
    qtd_fotos = 14;
    typeExtratorDeCaracteristicas = 2; % 2 - HOG; 3 - Somente PCA
    caminho = 'C:\Users\FlavioFilho\Documents\faculdade\9_Periodo\PDI\ProjetoFinal\ProjetoPDI\projetoFinal\faces\individuos\';
    cellSize = [4 4];
    config = 1; % 1 - HOG COM O CORPOR; 2 - HOG COM A FACE; 3 - SOMENTE HOG
vetor_acuracia = [];
vetor_acuracia_por_classe = [];
for k = 1:1
%% Ler o Comjunto de Treinamento e Teste
disp("Teste "+k);
porcertagem_teste = 0.3;

[X_train, Y_train,X_test,Y_test,X_train_aux,X_teste_aux] = lerImgs2(qtd_classes,qtd_fotos,porcertagem_teste,typeExtratorDeCaracteristicas,caminho,cellSize,config);
cd('C:\Users\FlavioFilho\Documents\faculdade\9_Periodo\PDI\ProjetoFinal\ProjetoPDI\projetoFinal\faces') % COLOQUE O ENDEREÇO !!!!
%cd('C:\Users\Gideon\Desktop\PUC\Graduacao\9º Período\CMP1084 - Processamento Digital de Imagens\N2\Listas de exercícios\Lista 6')

%% Gerar a PCA com o conjunto de treinamento
[P PC mn] = GerarPCs(X_train);

%% Avaliar o Conjunto de Teste
i= 1;
c = size(Y_test,2);
preditc_teste = [];
while(i <= c)
    x = X_test(:,i);
    d = Classificar(PC, ProjetarAmostra(x,mn,P,0));
    preditc_teste = [preditc_teste Y_train(d)];
    
    i = i + 1;
end
acuracia = sum(preditc_teste == Y_test)/length(Y_test)*100;
vetor_acuracia = [vetor_acuracia acuracia];
C = confusionmat(Y_test,preditc_teste);
acuraciaPorClasse = [];
qtd_fotos_teste = (qtd_fotos - ceil(qtd_fotos*(1-porcertagem_teste)));
for linha= 1:qtd_classes
    for coluna= 1:qtd_classes
        if(linha == coluna)        
            aux = C(linha,coluna)/qtd_fotos_teste;
            acuraciaPorClasse(linha) = aux*100;
        end    
    end
end
vetor_acuracia_por_classe(k,:) =  acuraciaPorClasse;
end
%% Resultados das Médias

acuracia_media = sum(vetor_acuracia)/length(vetor_acuracia);
disp("");
disp("Resultados:");
disp("Acuracia Média: "+acuracia_media+" %");
disp("Acuracia Média por Classe:");
for linha= 1:qtd_classes
    classe = vetor_acuracia_por_classe(:,linha);
    acuracia_media_por_classe = sum(classe)/length(classe);
    disp ("classe "+linha+": "+acuracia_media_por_classe+" %");   
end

%% Testar Indivíduos separadamente
i = 1;
h = fspecial('average',[2 2]);
while(i)
   im = input('Informe a imagem (entre aspas simples): '); %nome da pasta\imagem. Ex: '71-13.jpg'
   if(im == 0)
       break;
   end
   %1º parâmetro: endereço da pasta de imagens
   x = imread(strcat(caminho,strcat('\',im)));   % COLOQUE O ENDEREÇO !!!!
   if(config == 1)
      B = imfilter(x,h); % Filtro de Média.
      B = imadjust(B,[],[],0.8); % Gamma correction.
      x = imresize(B,0.5); % Redimensionar Imagem.
      x = imcrop(x,[50 0 220 240]); % Recortar somente o corpo.
   elseif(config == 2)
       B = imfilter(x,h); % Filtro de Média.
       B = imadjust(B,[],[],0.8); % Gamma correction.
       x = imresize(B,0.5);% Redimensionar Imagem.
       x = imcrop(x,[63 25 207 180]);% Recortar somente a face.
   else
      x = imresize(x,0.5);
   end
   x = rgb2gray(x);
   aux_x = ProjetarAmostra(x,mn,P,typeExtratorDeCaracteristicas);
   d = Classificar(PC, aux_x);
   figure;
   if(config == 1)
      imshowpair(reshape(X_train_aux(:,d),240,221),x,'montage')
   elseif(config == 2)
      imshowpair(reshape(X_train_aux(:,d),181,208),x,'montage')
   else
      imshowpair(reshape(X_train_aux(:,d),240,320),x,'montage')
   end
   
   
   clear im, clear x, clear d
    
end