function out = ddiff(x,y)
% Function to perform the divided difference recursive function
% x is a list of x-values
% y is a list of corresponding y-values

% data check
if length(y)~=length(x)
    disp('Error: x and y must be the same length')
    return
end

if length(y)==1
    out = y;
elseif length(y)==2
    out = (y(2)-y(1))/(x(2)-x(1));
else
    out = (ddiff(x(2:end),y(2:end))-ddiff(x(1:end-1),y(1:end-1)))/(x(end)-x(1)); % recursively calls itself
end

end