%define last_word 0

%macro word 2
w_%2:
    dq last_word
    db %1, 0
    db 0

xt_%2:
    dq %2_impl

%xdefine last_word w_%2
%endmacro
