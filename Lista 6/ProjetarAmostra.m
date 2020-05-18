%Projeta uma nova amostra no espaço vetorial P
%Entrada:
%   x = amostra a ser projetada
%   mn = média de cada coluna da matriz de dados
%   P = dados no novo espaço vetorial (autofaces no caso de imagens)
%Saída:
%   x = amostra no novo espaço vetorial
function x = ProjetarAmostra(x,mn,P,typeReshape,bag)
    if(typeReshape== 1) % SURF
        x = encode(bag, x); % feature vector.
        x = x';
    elseif (typeReshape== 2)
        x = extractHOGFeatures(x,'CellSize',[16 16]);
        x = transpose(x);
    elseif (typeReshape== 3)
        x = reshape(x,[size(x,1)*size(x,2),1]);
    else
        
    end
    x = double(x) - mn;
    x = P' * x;
end