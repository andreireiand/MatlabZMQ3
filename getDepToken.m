function getDepToken(message)

    % This function is called in main thread w/ text returned by worker
    
    %pid = feature('getpid');
    
try  
    tokens = strip(split(message,';'));
    
    key = str2double(tokens{3});    % as in price
    volSize = str2double(tokens{4});   % as in volume / size moved on that price

    % let's update executionDom for 'Last', 'Bid', 'Ask'
    %disp(strcat('PID: ', num2str(pid), '; In getDepToken: ', message));
    if strcmpi(tokens{2},'bid') 
        UpdateL2BidAskDom(key, volSize, true);
    elseif strcmpi(tokens{2},'ask')
        UpdateL2BidAskDom(key, volSize, false);
    end
catch ME
    disp(ME.getReport);
    rethrow(ME);
end
end


