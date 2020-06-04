%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Arlindo Galvão - PDI2019 %%
%%        MAIN             %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all, close all
%% Iniciar o par

    qtd_classes = 100;
    qtd_fotos = 14;
    typeExtratorDeCaracteristicas = 2;
    caminho = 'C:\Users\FlavioFilho\Documents\faculdade\9_Periodo\PDI\ProjetoFinal\ProjetoPDI\projetoFinal\faces\individuos\';
    cellSize = [4 4];
    bag = [];  
    %imds = imageDatastore(caminho,'IncludeSubfolders',true,'FileExtensions','.jpg');
    %bag = bagOfFeatures(imds);
   
    
%% Ler o Comjunto de Treinamento e Teste

porcertagem_teste = 0.3;

[X_train, Y_train,X_test,Y_test,X_train_aux,X_teste_aux] = lerImgs2(qtd_classes,qtd_fotos,porcertagem_teste,typeExtratorDeCaracteristicas,caminho,cellSize,bag);
cd('C:\Users\FlavioFilho\Documents\faculdade\9_Periodo\PDI\ProjetoFinal\ProjetoPDI\projetoFinal\faces') % COLOQUE O ENDEREÇO !!!!
%cd('C:\Users\Gideon\Desktop\PUC\Graduacao\9º Período\CMP1084 - Processamento Digital de Imagens\N2\Listas de exercícios\Lista 6')

% [X_train, Y_train,X_test,Y_test,X_train_aux,X_teste_aux] = lerImgs3(qtd_classes,qtd_fotos,porcertagem_teste,caminho);

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
disp("Acuracia Total:"+acuracia);
C = confusionmat(Y_test,preditc_teste);
acuraciaPorClasse = [];
qtd_fotos_teste = (qtd_fotos - ceil(qtd_fotos*(1-porcertagem_teste)));
disp("QTd: "+qtd_fotos_teste);
for linha= 1:qtd_classes
    for coluna= 1:qtd_classes
        if(linha == coluna)        
            aux = C(linha,coluna)/qtd_fotos_teste;
            acuraciaPorClasse(linha) = aux*100;
        end    
    end
end
for linha= 1:qtd_classes
    disp ("classe "+linha+": "+acuraciaPorClasse(linha)+" %");   
end

%% Testar Indivíduos separadamente
i = 1;
while(i)
   im = input('Informe a imagem (entre aspas simples): '); %nome da pasta\imagem. Ex: '71-13.jpg'
   if(im == 0)
       break;
   end
   %1º parâmetro: endereço da pasta de imagens
   x = imread(strcat(caminho,strcat('\',im)));   % COLOQUE O ENDEREÇO !!!!
   x = imresize(x,0.5);
   x = rgb2gray(x);
   aux_x = ProjetarAmostra(x,mn,P,typeExtratorDeCaracteristicas,bag);
   d = Classificar(PC, aux_x);
   figure;
   imshowpair(reshape(X_train_aux(:,d),240,320),x,'montage')
   
   clear im, clear x, clear d
    
end