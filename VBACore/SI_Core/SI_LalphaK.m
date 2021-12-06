function [lAlphaK, lalphaKSingle, Kij] = SI_LalphaK(JunctionAttched)
fref=1000;
lAlphaK=0;
for ii = 1:4
    if strcmp(JunctionAttched{ii}.Type, 'CrossJunction')
        Kij{ii}=SI_KijCrossJunction(JunctionAttched{ii}.Elements);
    else
        Kij{ii}=SI_KijTJunction(JunctionAttched{ii}.Elements);
    end
    
    alphaK(1,ii) = sum(sqrt(JunctionAttched{ii}.fcj ./ fref) .* 10.^(-0.1 .* Kij{ii}(1,:)));
    lalphaKSingle(:,ii) = (sqrt(JunctionAttched{ii}.fcj ./ fref) .* 10.^(-0.1 .* Kij{ii}(1,:))).* JunctionAttched{1}.JunLens(ii);
    
    lAlphaK = lAlphaK + alphaK(1,ii).* JunctionAttched{1}.JunLens(ii);
end
end

