% Script to plot image of measured temperature, and trace it using the mouse.
%
% Image from http://www.columbiassacrifice.com/techdocs/techreprts/AIAA_2001-0352.pdf
% Now available at 
% http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.26.1075&rep=rep1&type=pdf
%
% D N Johnston 30/01/19name = 'temp597';

name = 'temp597';
img=imread([name '.jpg']);

for i=1:size(img,2)
  Red=img(:,i,1);
  Green= img(:,i,2);
  Blue= img(:,i,3);
  initialtempdata(i)=mean(find(Red>110 & Blue<90 & Green<70)); % Scans pixels of image
end

%Ignore any points outside the function
initialtempdata(isnan(initialtempdata))=[];

%Flip the temperature vector
tempdataflip=max(initialtempdata)-initialtempdata;
%Convert pixels to Farenheit
tempdataF=(1500/max(tempdataflip))*tempdataflip;
%Changing to deg C
tempdata=(tempdataF-32)/1.8;

%Create time vector
time = (1:1:size(initialtempdata,2));
%Convert from pixels to seconds
finaltime = time*(2000/max(time));

% Plot graph
plot(finaltime,tempdata,'r')
xlabel('Time (s)')
ylabel('Temperature (deg)')

% Temp and time data saved 
save(name, 'timedata', 'tempdata')
