%% 
%     COURSE: Master MATLAB through guided problem-solving
%    SECTION: Importing and exporting data
%      VIDEO: Import formatted text file
% Instructor: mikexcohen.com
%
%%

% pointer to the file
fid = fopen('datafile.txt'); % make sure that the value it gives is not -1. Because that would mean that either their is an 
%error in that file's name or that it is not within MATLAB's path. 

%% read header
% ignore first line
IgnoreFirstLine = fgetl(fid); %fgetl stands for file get line 

% second line contains number of sensors
hdr_nSensors = regexp(fgetl(fid),'\t','split'); %This MATLAB function returns the starting index of each substring of str 
%that matches the character patterns specified by the regular expression.
nSensors = str2double(hdr_nSensors(3));% we want to extract the number of sensors from the previous line. 

% third line contains number of time points
hdr_ntimepoints = regexp(fgetl(fid),'\t','split');
nPnts = str2double(hdr_ntimepoints(3));

% move pointer ahead until "Start data"
toggle = true;
while toggle 
    
    % get a line of data
    aline = fgetl(fid);
    
    % test whether the line begins with "Start", and flip toggle
    % the strcmpi is used to compare strings (case insensitive)
    if strcmpi(aline(1:5),'Start')
        toggle = false 
    end
end

%% read data

% initialize matrix
data = zeros(nSensors,nPnts);

% set toggle and begin while loop
toggle = true;
while toggle
    
    % get a line of tab-delimited data
    aline = regexp(fgetl(fid),'\t','split'); %this gives a cell array 
    
    % check whether we're at the end of the data
    if strcmpi(aline{1}(1:3),'end') % enter first cell for comparison
        % Compare strings (case insensitive)
        toggle = false
    else
        % put the data point into the matrix at the appropriate position
        data( str2double(aline{2}) ,str2double(aline{4})) = str2double(aline{6})
        %data(row location (sensor num), column location(time point)) = value want to assign for that specific
        %location
    end
    
   
    
end

% now we can plot the data
figure(1), clf
plot(data','linew',2)

%%
