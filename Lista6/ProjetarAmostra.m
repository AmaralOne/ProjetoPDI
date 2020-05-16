%Projeta uma nova amostra no espa�o vetorial P
%Entrada:
%   x = amostra a ser projetada
%   mn = m�dia de cada coluna da matriz de dados
%   P = dados no novo espa�o vetorial (autofaces no caso de imagens)
%Sa�da:
%   x = amostra no novo espa�o vetorial
function x = ProjetarAmostra(x,mn,P,typeReshape)
    if(typeReshape== 1)
        x = reshape(x,[size(x,1)*size(x,2),1]);
    elseif (typeReshape== 2)
        x = extractHOGFeatures(x,'CellSize',[16 16]);
        x = transpose(x);
    else
        
    end
    x = double(x) - mn;
    x = P' * x;
end