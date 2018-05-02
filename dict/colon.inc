%define head 0

%macro colon 2
%%head: dq head
db %1, 0
xt_ %+ %2:

%define head %%head
%endmacro
