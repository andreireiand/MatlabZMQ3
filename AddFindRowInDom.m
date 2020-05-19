function row = AddFindRowInDom(key, paus)
%UNTITLED Summary of this function goes here
%   

    global executionDom  
    global priceCol
try

    row = find(executionDom(:,priceCol)==key, 1);
    if isempty(row) 
        row = size(executionDom,1)+1; 
        executionDom(row,:) = initLine(0,key,0,0,0,0,0,0,paus,0,0);
        executionDom = sortrows(executionDom, priceCol,'descend');
        row = find(executionDom(:,priceCol)==key, 1);
    end
    
    assert(~isempty(row));
    
catch ME
    disp(ME.message);
    rethrow(ME);
end     
end

