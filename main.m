%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Arlindo Galvão - PDI2019 %%
%%        MAIN             %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all, close all

qtd_classes = 40;
qtd_fotos = 10;

porcertagem_teste = 0.3;

[X_train, Y_train,X_test,Y_test] = lerImgs(qtd_classes,qtd_fotos,porcertagem_teste);

 cd('C:\Users\FlavioFilho\Documents\faculdade\9_Periodo\PDI\N2-1\pca') % COLOQUE O ENDEREÇO !!!!

[P PC mn] = GerarPCs(X_train);

i= 1;
c = size(Y_test,2);
preditc_teste = [];
while(i <= c)
    i
    x = X_test(:,i);
    d = Classificar(PC, ProjetarAmostra(x,mn,P));
    preditc_teste = [preditc_teste Y_train(d)];
    
    i = i + 1;
end


acuracia = sum(preditc_teste == Y_test)/length(Y_test)*100;
acuracia

%%Um resumo de linha normalizado de linha exibe as porcentagens de observações classificadas correta e incorretamente para cada classe verdadeira. Um resumo da coluna normalizado da coluna exibe
%%as porcentagens de observações classificadas correta e incorretamente para cada classe prevista.
C = confusionmat(Y_test,preditc_teste);
figure();
cm = confusionchart(C);


acuraciaPorClasse = [];
for linha= 1:qtd_classes
    for coluna= 1:qtd_classes
        if(linha == coluna)        
            aux = C(linha,coluna)/ceil(qtd_fotos*(porcertagem_teste));
            acuraciaPorClasse(linha) = aux*100;
        end    
    end
end
for linha= 1:qtd_classes

    disp ("classe "+linha+": "+acuraciaPorClasse(linha)+" %");
    
end


i = 1;

while(i)
   im = input('Informe a imagem (entre aspas simples): '); %nome da pasta\imagem. Ex: 's39\3.pgm'
   if(im == 0)
       break;
   end
   %1º parâmetro: endereço da pasta de imagens
   x = imread(strcat('C:\Users\FlavioFilho\Documents\faculdade\9_Periodo\PDI\N2-1\pca\orl_faces',strcat('\',im)));   % COLOQUE O ENDEREÇO !!!!
   d = Classificar(PC, ProjetarAmostra(x,mn,P));
   
   figure;
   imshowpair(reshape(X_train(:,d),112,92),x,'montage')
   
   clear im, clear x, clear d
    
end