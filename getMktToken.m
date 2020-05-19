function getMktToken(message)

    % This function is called in main thread w/ text returned by worker
    
    pid = feature('getpid');
    
try  
    tokens = strip(split(message,';'));
    
    key = str2double(tokens{3});    % as in price
    volSize = str2double(tokens{4});   % as in volume / size moved on that price

        % since bid/ask levels are always updated in Market Token (not only
        % Limit Tokens, and since any execution / order withdraw will
        % trigger such a bid/ask L1 update, it makes sense to place a hook
        % only here (for order execution). This also means I may ignore
        % completely L2 updates ... for purpose of order execution. However, 
        % L2 queue updates can modify relative order queue number   
    
    % let's update executionDom for 'Last', 'Bid', 'Ask'
    %disp(strcat('PID: ', num2str(pid), '; In getMktToken: ', message));
    if strcmpi(tokens{2},'last')
        %disp(strcat('PID: ', num2str(pid), '; In getMktToken: ', message));
        disp(strcat('PID: ', num2str(pid), '; In getMktToken: ', tokens{5}));
        UpdateExecutionDom(key, volSize, key == str2double(tokens{9}));
        % UpdateOrders(tokens); % this shouldn't happen ... as volume =
        % size exeucted; and past this event, a bid/ask L1 update will
        % clearly specify the size of the new queue
    elseif strcmpi(tokens{2},'bid') 
        UpdateL1BidAskDom(key, volSize, 1);
        UpdateOrders(tokens, 1);
    elseif strcmpi(tokens{2},'ask')
        UpdateL1BidAskDom(key, volSize, -1);
        UpdateOrders(tokens, -1);
    end
catch ME
    disp(ME.getReport);
    rethrow(ME);
end
end


