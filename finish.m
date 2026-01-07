function finish
% FINISH - Script executed when MATLAB exits
%   This script ensures a graceful shutdown by closing windows and 
%   releasing file locks, which prevents VS Code extension hangs.

    try
        disp('Running finish.m cleanup...');

        % 1. Close all open figure windows
        %    (Prevents UI threads from hanging the process)
        close all hidden;
        
        % 2. Close all open file identifiers 
        %    (Crucial for scripts that read/write images or logs)
        fclose('all');
        
        % 3. Close open Java objects if you use them (optional)
        %    (Java memory leaks are a common source of MATLAB exit crashes)
        % javacleanup; % Uncomment if you use custom Java objects

        disp('Cleanup complete. Goodbye!');
        
    catch ME
        % If something fails during shutdown, print error but don't block exit
        warning('Error during finish.m execution: %s', ME.message);
    end

end