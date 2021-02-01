%____________________________________

% Author        - Vitamin-C
% Status        - Functional
% Description   - Examines the names of files in a directory cd in
%                 comparison to the expected list of names (at expected_files_list) and
%                 saves the list of differences between the list and
%                 existing files at sav_dir\save_name
% Use Comments  - Set up various dir for first time use              

clear all
close all
%________________________________________________________________________

cd(%file dir);
dir_name = cd;
expected_files_list = %somedir.xlsx;
sav_dir = %set save directory;
save_name = %set name.xlsx; 

%_________________________________
% Set the functionality of the program

files = dir(cd);
files = {files.name}';
files = files(3:end); 
files = reverse(files); % This is done to avoid problems with file names containing ".".

dot_location = strfind(files, '.'); 

for i=1:length(dot_location) 
    % Determine the file extension
    file_dot_location(i)=dot_location{i, 1}(1, 1); 
end

file_dot_location=file_dot_location';
files = reverse(files); % Filp the file names back to their original direction

for j=1:length(files)
    % Determine what the file name minus the extension is
    f_name_im = files{j, 1}(1:end - DotLocation(j));
    f_name_img{j, 1} = f_name_im; % Create an array of file names
end

expected_names = importdata(expected_files_list);
f_name_from_list = expected_names(:,1); % Get the file names we expect to be present
unique_image = setdiff(f_name_img,f_name_from_list);
unique_file_names = setdiff(f_name_from_list,f_name_img);
[m, n] = size(unique_file_names);
[q, r] = size(unique_image);

if m == 0 
    %Get around problems inherrent in empty sets of missing entries
    unique_file_names{1,1} = 'No Missing Entries';
end

if q == 0
    unique_image{1,1} = 'No Missing Entries';
end

save_directory = strcat(save_dir, '\', somename);

%Here we create the output Excel document
writematrix('Unmatched Image Names in Image file list', save_directory, 'Sheet', 1, 'Range', 'A1');
writematrix('Unmatched File Names in Excel Document', save_directory, 'Sheet', 1, 'Range', 'B1');
writecell(unique_image,save_directory, 'Sheet', 1, 'Range', 'A2');
writecell(unique_file_names,save_directory, 'Sheet', 1, 'Range', 'B2');
