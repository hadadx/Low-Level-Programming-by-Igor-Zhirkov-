%ifndef MACROS_INC
%define MACROS_INC

default abs

; Forth VM register aliases.
%define pc r15
%define w r14
%define rstack r13

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

%endif
