#No more than one space between tokens
/^[ \t]*\//! s:([a-zA-Z]+) +([a-zA-Z]+):\1 \2:g
s:([a-zA-Z]+) +\(:\1 (:g 
