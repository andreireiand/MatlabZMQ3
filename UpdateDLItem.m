function rez = UpdateDLItem(oldValue, action, newValue)
%
%
%
    % 0     = leave unchanged
    % 1     = add to existing value
    % -1    = substract new from existing value
    % 2     = replace
    % -2    = substract existing from new value
    
    % 
try    
    if action == 1
        rez = oldValue + newValue;
    elseif action == -1
        rez = oldValue - newValue;
    elseif action == 2 
        rez = newValue;
    elseif action == -2
        rez = newValue - oldValue;
    elseif action == 0
        disp('In UpdateDLItem; action = 0; this branch should never be reached!');
    end
catch ME
    disp(ME.getReport);
    rethrow(ME);
end      
end

 