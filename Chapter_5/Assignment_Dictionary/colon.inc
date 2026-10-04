%define last_word 0

%macro clone 2
%2:
    dq last_word
    db %1,0

%define last_word %2
%endmacro